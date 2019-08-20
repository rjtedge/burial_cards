require 'mechanize'
require 'scraperwiki'

agent = Mechanize.new
urlbase = 'https://www.dutchjewry.org/phpr/amsterdam/port_isr_gem_burials/amsterdam_port_isr_gem_burials_view.php?editid1='

pagenum = 1

while pagenum <= 27680
  page = agent.get(urlbase + pagenum.to_s)
  burialdate = page.at('.fieldvalue_begraafdatum').inner_text.strip
  archivecardnum = page.at('.fieldvalue_archiefkaartnummer').inner_text.strip
  familyfnameone = page.at('.fieldvalue_familienaam_1').inner_text.strip
  familyfnametwo = page.at('.fieldvalue_familienaam_2').inner_text.strip
  firstname = page.at('.fieldvalue_voornaam').inner_text.strip
   
  record  = {
       recordnumber: pagenum,
       burialdate: burialdate,
       archivecardnum: beds,
       familyfnameone: baths,
       familyfnametwo: cars,
       firstname: agents
     }    
      ScraperWiki.save_sqlite([:recordnumber], record )
  pagenum += 1
end
