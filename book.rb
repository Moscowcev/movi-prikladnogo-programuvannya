class Book

  def initialize(name = "Blank", author = "Nobody", year = "0")
    @name = name
    @author = author
    @year = year
  end

  def name
    @name
  end

  def name=(value)
    @name = value
  end

  def author
    @author
  end

  def author=(value)
    @author = value
  end

  def year
    @year
  end

  def year=(value)
    @year = value
  end

end