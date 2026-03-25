library(quarto)
library(tools)
library(fs)
library(tidyverse)


fs::dir_create("output")

poem_files <- fs::dir_ls("poems", glob = "*.md")

for (f in poem_files) {
  
  # take filename without extension
  poem_titel <- path_ext_remove(path_file(f)) |>
    stringr::str_replace_all("_", " ")
  
  
  
  # make safe filename for PDF
  safe_name <- poem_titel |>
    str_replace_all("[^[:alnum:]一-龥]+", "_")
  
  quarto_render(
    input = "taak.qmd",   # <-- change this to your actual filename
    output_file = paste0(safe_name, ".pdf"),
    # output_dir = here::here("output"),
    execute_params = list(
      poem_file = f,
      poem_titel = poem_titel
    )
  )
}