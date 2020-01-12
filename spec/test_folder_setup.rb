require_relative("../app/src/folder_setup")
require 'json'
require 'io/console'
require 'fileutils'


RSpec.describe Folder_Setup do
    before do
		allow($stdout).to receive(:write)
	end
    describe ".confirm_folder_exists" do
        it("check if folder exists") do
            folder_setup = Folder_Setup.new()
            allow($stdin).to receive(:gets).and_return("folder","test","test","test","test")
            $stdin.gets
            allow_any_instance_of(Inputs).to receive(:check).and_return(true)
            object = Inputs.inputsToUser()
            
            allow(folder_setup).to receive(:check_local_directory_exists).and_return(false)
            allow(folder_setup).to receive(:check_remote_exists).and_return(true)
            folder_setup.confirm_folder_exists('dir', object)
        end
        
    end

    describe ".notify" do
        it("when can't find directory")do
            folder_setup = Folder_Setup.new()
            allow($stdin).to receive(:gets).and_return("folder","test","test","test","test")
            $stdin.gets
            allow_any_instance_of(Inputs).to receive(:check).and_return(true)
            object = Inputs.inputsToUser()
            
            allow(Inputs).to receive(:folderName).and_return(true)
            allow(folder_setup).to receive(:confirm_folder_exists).and_return(true)
            folder_setup.notify('dir', object)
        end
    end

    describe ".clone_master" do
        it("remove folders and clone master")do
            # folder_setup = Folder_Setup.new()
            # allow($stdin).to receive(:gets).and_return("folder","test","test","test","test")
            # $stdin.gets
            # credentials = {
			# 	user: 'login1',
			# 	pass: 'pass1'
			# }
            # allow_any_instance_of(Inputs).to receive(:check).and_return(credentials)
            # object = Inputs.inputsToUser()
            
            # #zakomentować
            # #expect(folder_setup).to receive(:clone_master).with('dir', object)
            # folder_setup.clone_master('dir', object)
        end
    end

    describe ".check_remote_exists" do
        it("check when remote doesn't exists") do
            folder_setup = Folder_Setup.new()
            account = { :user => "user"}
            expect(folder_setup.check_remote_exists(account, 'dir1')).to be_falsey
        end

        it("check when remote exists") do
            folder_setup = Folder_Setup.new()
            account = { :user => "user"}

            #expect(folder_setup.check_remote_exists(account, 'dir1')).to be_truthy
        end
    end

    describe ".check_local_directory_exists" do
        it("check not existing local directory") do
            folder_setup = Folder_Setup.new()
            allow($stdin).to receive(:gets).and_return("folder","test","test","test","test")
			$stdin.gets
            allow_any_instance_of(Inputs).to receive(:check).and_return(true)
            object = Inputs.inputsToUser()
            expect(folder_setup.check_local_directory_exists('dir3', object)).to be_falsey
        end

        it("check existing local directory")do
            folder_setup = Folder_Setup.new()
            allow($stdin).to receive(:gets).and_return("folder","test","test","test","test")
			$stdin.gets
            allow_any_instance_of(Inputs).to receive(:check).and_return(true)
            object = Inputs.inputsToUser()
            str = "../dir1/"
            str.concat(object[:f])
            FileUtils.mkdir_p str
            expect(folder_setup.check_local_directory_exists('dir1', object)).to be_truthy
        end
    end
end