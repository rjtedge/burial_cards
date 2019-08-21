require 'mechanize'
require 'scraperwiki'

agent = Mechanize.new
urlbase = 'https://www.dutchjewry.org/phpr/amsterdam/port_isr_gem_burials/amsterdam_port_isr_gem_burials_view.php?editid1='

pagenum = 27765

while pagenum <= 27854
 
     p pagenum
  
  page = agent.get(urlbase + pagenum.to_s)
  page.at('.fieldvalue_begraafdatum') == nil ? (burialdate = "") : (burialdate = page.at('.fieldvalue_begraafdatum').inner_text.strip)
  page.at('.fieldvalue_archiefkaartnummer') == nil ? (archivecardnum = "") : (archivecardnum = page.at('.fieldvalue_archiefkaartnummer').inner_text.strip)
  page.at('.fieldvalue_familienaam_1') == nil ? (familyfnameone = "") : (familyfnameone = page.at('.fieldvalue_familienaam_1').inner_text.strip)
  page.at('.fieldvalue_familienaam_2') == nil ? (familyfnametwo = "") : (familyfnametwo = page.at('.fieldvalue_familienaam_2').inner_text.strip)
  page.at('.fieldvalue_voornaam') == nil ? (firstname = "") : (firstname = page.at('.fieldvalue_voornaam').inner_text.strip)
  page.at('.fieldvalue_positie') == nil ? (location = "") : (location = page.at('.fieldvalue_positie').inner_text.strip)
  page.at('.fieldvalue_veld') == nil ? (field = "") : (field = page.at('.fieldvalue_veld').inner_text.strip)
  page.at('.fieldvalue_rij') == nil ? (row = "") : (row = page.at('.fieldvalue_rij').inner_text.strip)
  page.at('.fieldvalue_graf') == nil ? (grave = "") : (grave = page.at('.fieldvalue_graf').inner_text.strip)

  gravestonephotourl = ""
  if page.at('.fieldvalue_foto_grafsteen_aanwezig img').values[0] == "images/check_yes.gif"
    p gravestonephotourl = page.at('.fieldvalue_grafsteen_1 img').attributes['src'].value
  end

   
  record  = {
       recordnumber: pagenum,
       burialdate: burialdate,
       archivecardnum: archivecardnum,
       familyfnameone: familyfnameone,
       familyfnametwo: familyfnametwo,
       firstname: firstname,
       location: location,
       field: field,
       row: row,
       grave: grave,
       gravestonephotourl: gravestonephotourl
     }    
      ScraperWiki.save_sqlite([:recordnumber], record )
  pagenum += 1

end
