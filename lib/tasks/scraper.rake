namespace :scraper do
  desc 'Scrape the study guide'
  task scrape: :environment do
    mechanize = Mechanize.new

    def get_onderdelen(pagina, mechanize)
      res = []
      _get_onderdelen(pagina, res, mechanize)
      res
    end

    def _get_onderdelen(pagina, list, mechanize)
      pagina.iframes.uniq(&:content).each do |i|
        if pagina == i.content
          pagina.search('.openklapper').each do |openklapper|
            base = i.content.uri.to_s.split('/')[0..-2].join('/')
            tail = openklapper.attributes['onclick'].content.match(/\'(.*?)\'/)[1]
            full = "#{base}/#{tail}.html"

            _get_onderdelen(mechanize.get(full), list, mechanize)
          end
        else
          _get_onderdelen(i.content, list, mechanize)
        end
      end

      list << pagina unless pagina.iframe
    end

    # Setup
    page = mechanize.get('http://studiegids.ugent.be')
    page = page.link_with(text: 'Per faculteit').click

    # Zoek alle faculteiten
    faculteiten = page.links_with(text: /Faculteit .*/, href: /[A-Z]/)

    faculteiten.each do |f|
      fac = f.click

      hoofdframe = fac.iframe_with(id: 'hoofdframe').content
      faculteitsnaam = hoofdframe.search('.faculteit').first.text
      faculteitscode = f.attributes['href']

      faculty = Faculty.find_by(code: faculteitscode) || Faculty.new
      faculty.name = faculteitsnaam
      faculty.code = faculteitscode
      faculty.save

      puts faculty.name

      # Elk type opleiding bevindt zich in een iframe
      hoofdframe.iframes.each do |i|
        # De htmlpagina van elk programma wordt opgevraagd
        uri = URI.join(fac.uri.to_s, "#{i.dom_id}/#{i.dom_id}.html")
        programmas = mechanize.get(uri)

        programmas.links.each do |proglink|
          programmacode = proglink.attributes['href'].split('/')[-2]
          prog = proglink.click
          prog_url = prog.uri.to_s

          opleidingsnaam = prog.search('.opleidingsnaam').text

          programme = Programme.find_by(code: programmacode) || Programme.new
          programme.name = opleidingsnaam
          programme.code = programmacode
          programme.faculty = faculty
          programme.url = prog_url
          programme.save

          puts "\t#{programme.name} - #{programme.code}"

          get_onderdelen(prog, mechanize).each do |onderdeel|
            onderdeel.search('.rowclass').each do |row|
              data = {}
              # Get data from course
              row.search('td').each do |td|
                data[td.attributes['class'].value] = td.text
              end

              # Haal de ECTS code uit de url van de fiche
              studiefiche = row.search('td.cursus a').first.attributes['href']
              if studiefiche
                code = studiefiche.value.split('/').last.split('.').first
                data['studiefiche'] = "http://studiegids.ugent.be#{studiefiche.value}"
              end

              # Get lecturer data from site
              lesgever = row.search('td.lesgever a')
              unless lesgever.empty?
                lesgever_url = lesgever.first.attributes['href'].value unless lesgever.empty?
                lesgever_code = lesgever_url.split('=').last

                # Create or update lecturer in database
                lecturer = Lecturer.find_by(code: lesgever_code) || Lecturer.new
                lecturer.name = data['lesgever']
                lecturer.code = lesgever_code
                lecturer.url = lesgever_url
                lecturer.save
              end

              # Create course in database
              course = if code.nil?
                         Course.new
                       else
                         Course.find_by(code: code) || Course.new
                       end

              course.name = data['cursus']
              course.semester = data['semester']
              course.studyhours = data['studietijd']
              course.credits = data['studiepunten']
              course.code = code if code
              course.lecturer = lecturer if lecturer
              course.programmes << programme unless course.programmes.include?(programme)
              course.ects_url = data['studiefiche']
              course.save

              puts "\t\t#{course.name}"
            end
          end
        end
      end
    end
  end
end
