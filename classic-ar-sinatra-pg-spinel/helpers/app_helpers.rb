helpers do

  def pick_random_line
    @line ||= File.readlines("public/quotes.txt").sample
  end

end
