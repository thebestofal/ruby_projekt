require 'fileutils'
require 'json'
require 'io/console'
require_relative("../app/src/inputs")

RSpec.describe Inputs do
	before do
		#allow($stdout).to receive(:write)
	end
	
    describe ".recollect_account_credentials" do
        it("test recollecting login and password from input") do
			allow($stdin).to receive(:gets).and_return('login2','pass2')
			inputs = Inputs.new()
			#inputs = object_double(Inputs.new)
			credentials = {
				user: 'login1',
				pass: 'pass1'
			}
			expect(inputs.recollect_account_credentials(credentials, 'test_type')).to eq({:pass=>"pass2", :user=>"login2"})
			$stdin.gets
		end
    end

    describe ".check" do
        it("valid account credentials") do
		
		inputs = Inputs.new()
		credentials = {
			user: 'login1',
			pass: 'pass1'
		}
		
		allow($stdin).to receive(:gets).and_return("login2","pass2")
		allow_any_instance_of(Inputs).to receive(:check).and_call_original
		allow_any_instance_of(Inputs).to receive(:check).with({:pass=>"pass2", :user=>"login2"}, "testing").and_return(true)
		inputs.check(credentials,'testing')
		$stdin.gets
        end
    end
	
	describe ".inputsToUser" do
        it("method returns correct values") do
			allow($stdin).to receive(:gets).and_return("folder","test","test","test","test")
			$stdin.gets
			allow_any_instance_of(Inputs).to receive(:check).and_return(true)
			expect(Inputs.inputsToUser()).to eq({:f=>"test", :j=>true, :m=>true})
		end
    end

    describe ".folderName" do
        it("takes folder name string input") do	
			
			allow($stdin).to receive(:gets).and_return("folder")
			expect(Inputs.folderName()).to eq( "folder")
			$stdin.gets # => "one"
        end
		it("takes empty folder name string input") do	
			
			allow($stdin).to receive(:gets).and_return("")
			expect(Inputs.folderName()).to eq( "")
			$stdin.gets # => "one"
        end
    end
	
	describe ".accountName" do
        it("takes name string input") do
			
			inputs = Inputs.new()
			allow($stdin).to receive(:gets).and_return("user")
			expect(inputs.accountName("")).to eq("user")
			$stdin.gets 
		end
		it("takes empty name string input") do
			
			inputs = Inputs.new()
			allow($stdin).to receive(:gets).and_return("")
			expect(inputs.accountPassword("")).to eq("")
			$stdin.gets 
        end
    end
	
	describe ".accountPassword" do
        it("takes password string input") do
			
			inputs = Inputs.new()
			allow($stdin).to receive(:gets).and_return("password")
			expect(inputs.accountName("")).to eq("password")
			$stdin.gets 
		end
		it("takes empty password string input") do
			
			inputs = Inputs.new()
			allow($stdin).to receive(:gets).and_return("")
			expect(inputs.accountPassword("")).to eq("")
			$stdin.gets 
		end
    end
end