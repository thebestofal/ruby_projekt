require_relative("../app/src/app_controller")
RSpec.describe AppController do
    describe ".surface_folder_level" do
        it("creates readme and a repository") do
            app_controller = AppController.new()
            environment = object_double(GithubModifier.new) # mock
            account = { :user => "user"}
            expect(environment).to receive(:create_Repo_From_subFolder).with(".", account)
            app_controller.surface_folder_level(".", account, true, environment)
        end
        it("deletes existing repository") do
            app_controller = AppController.new()
            environment = object_double(GithubModifier.new) # mock
            account = { :user => "user"}
            expect(environment).to receive(:delete_online_repo).with(".", account)
            app_controller.surface_folder_level(".", account, false, environment)
        end
    end

    describe ".sub_folder_level" do
        it("returns true if file .submodulized exists") do
            
        end
        it("returns false if file .submodulized doesn't exists") do
            
        end
    end

    describe ".confirm_expected_subfolders_exist" do
        it("creates .submodulized file") do
            
        end
    end

    describe ".master_has_subfolders_or_is_subfolder_already" do
        it("creates .submodulized file") do
            
        end
    end

    describe ".folder_counter" do
        it("creates .submodulized file") do
            
        end
    end

    describe ".initialize_submodule" do
        it("creates .submodulized file") do
            
        end
    end

    describe ".automate" do
        it("creates .submodulized file") do
            
        end
    end
end