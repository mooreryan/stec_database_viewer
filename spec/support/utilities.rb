# will eventually be replaced by a test that 
# tests the original full_title helper directly

def full_title page_title
  base_title = "Moomint BDBC"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end
