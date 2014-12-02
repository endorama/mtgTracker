
class String
  # convert from CamelCase to snake_case
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end

  # check if a string is numeric
  def numeric?
    Float(self) != nil rescue false
  end
end
