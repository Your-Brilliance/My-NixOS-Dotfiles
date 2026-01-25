return {
  '3rd/image.nvim',
  opts = {
    backend = 'sixel',
    max_width = 100,
    max_height = 12, -- This matches molten_virt_lines_off_by_1
    max_height_window_percentage = 40,
    max_width_window_percentage = 60,
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = {'cmp_menu', 'cmp_docs', ''},
  }
}
