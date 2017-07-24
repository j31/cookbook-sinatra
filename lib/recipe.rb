class Recipe
  attr_accessor :name, :description, :cooking_time, :tested, :difficulty

  def initialize(name, description, cooking_time, tested = false, difficulty = "")
    @name = name
    @description = description
    @cooking_time = cooking_time
    @tested = tested
    @difficulty = difficulty
  end

  def toggle_tested
    if @tested == true
      @tested = false
    else
      @tested = true
    end
  end

  def update_name(value)
    @name = value
  end

  def update_cooking_time(value)
    @cooking_time = value
  end

  def update_difficulty(value)
    @difficulty = value
  end

  def update_description(value)
    @description = value
  end

  def tested?
    if @tested
      return "Yes"
    else
      return "No "
    end
  end
end
