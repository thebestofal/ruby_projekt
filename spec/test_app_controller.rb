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
        it("initializes submodule from subfolder, commits and pushes") do
            app_controller = AppController.new()
            environment = object_double(GithubModifier.new) # mock
            account = { :user => "user"}
            expect(environment).to receive(:removeFiles_addSubmodule).at_least(1).times()
            expect(environment).to receive(:commit_andPush).at_least(1).times()
            allow_any_instance_of(AppController).to receive(:initialize_submodule)
            app_controller.sub_folder_level(".", account, true, environment)
        end
        it("just initializes submodule from subfolder") do
            app_controller = AppController.new()
            environment = object_double(GithubModifier.new) # mock
            account = { :user => "user"}
            expect_any_instance_of(AppController).to receive(:initialize_submodule).at_least(1).times()
            app_controller.sub_folder_level(".", account, false, environment)
        end
    end

    describe ".master_has_subfolders_or_is_subfolder_already" do
        it("returns true if is a subfolder") do
            app_controller = AppController.new()
            expect(app_controller.master_has_subfolders_or_is_subfolder_already("", "not master")).to eq(true)
        end
    end

    describe ".confirm_expected_subfolders_exist" do
        it("confirms backup folders are the same as current") do
            app_controller = AppController.new()
            allow_any_instance_of(AppController).to receive(:folder_counter).and_return(true)
            expect(app_controller.confirm_expected_subfolders_exist("", "")).to eq(true)
        end
    end

    describe ".folder_counter" do
        # it("counts folders in given directory") do
        #     app_controller = AppController.new()
        #     allow_any_instance_of(Dir).to receive(:foreach).and_yield(".")
        #     expect(app_controller.folder_counter("")).to eq(0)
        # end
    end

    describe ".initialize_submodule" do
        it("initializes submodule if any exist") do
            app_controller = AppController.new()
            environment = object_double(GithubModifier.new) # mock
            object = { :m => "user"}
            allow_any_instance_of(AppController).to receive(:master_has_subfolders_or_is_subfolder_already).and_return(true)
            allow_any_instance_of(AppController).to receive(:surface_folder_level).with("", "user", false, environment)
            allow_any_instance_of(AppController).to receive(:sub_folder_level).with("", object, false, environment)
            app_controller.initialize_submodule("", object, false, "master", environment)
        end
    end

    describe ".automate" do
        it("removes folder from GitHub") do
            allow_any_instance_of(Folder_Setup).to receive(:confirm_folder_exists).and_return({:f => "user"})
            allow_any_instance_of(AppController).to receive(:confirm_expected_subfolders_exist).and_return(false)
            allow_any_instance_of(AppController).to receive(:initialize_submodule)

            AppController.automate("", {:m => "user"}, false, "master")
        end

        it("initializes whole repository") do
            allow_any_instance_of(Folder_Setup).to receive(:confirm_folder_exists).and_return({:f => "user"})
            allow_any_instance_of(AppController).to receive(:confirm_expected_subfolders_exist).and_return(false)
            allow_any_instance_of(AppController).to receive(:initialize_submodule)

            AppController.automate("", {:m => "user"}, true, "master")
        end
    end
end