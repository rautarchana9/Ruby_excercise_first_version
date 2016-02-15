require 'prawn'

$headers = [:Name, :Age, :Education, :Place, :Marital_status ]
class UserInterface

  attr_reader :user_info
  
  def initialize
    @intro = "Welcome to the Resume Generator program please enter 
              your details to export your resume in csv format"
    #@headers = [:Name, :Age, :Education, :Place, :Marital_status ]
  end

  def display_intro
    puts @intro
  end

  def collect_user_info
    @user_info = Hash.new
    $headers.each do |key|
      puts key.to_s, ":"
      @user_info[key] = gets
    end
  end
end
   
class GenerateCSV
  def self.export_user_info(hash)
    file = File.open("Resume.csv", "w+")
    hash.each do |key, value|
      file << "#{key}, #{value}\n"
    end
    file.close
  end
end

class GeneratePDF
  def self.export_user_info(hash)
    Prawn::Document.generate("Resume.pdf")do
      hash.each{|key, value| text "#{key} : #{value}"}
    end
  end
end

class FactoryClass
  def self.create(class_name, user_info)
    obj = Object.const_get(class_name)
    obj.new(user_info)
  end
end

instance1 = UserInterface.new
instance1.display_intro
instance1.collect_user_info
GeneratePDF.export_user_info(instance1.user_info)

#FactoryClass.create("GeneratePDF", [instance1.user_info])