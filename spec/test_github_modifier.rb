require 'fileutils'
require 'json'
require 'io/console'
require_relative("../app/src/github_modifier")

RSpec.describe GithubModifier do
	before do
		allow($stdout).to receive(:write)
	end
	
    describe ".start_repo_locally" do
        it("creates repo and commits") do
			git = GithubModifier.new()
			git.start_repo_locally
		end
    end

    describe ".establish_Origin_repo" do
        it("remote rm/add origin") do
		git = GithubModifier.new()
		credentials = {
			user: 'login1',
			pass: 'pass1'
		}
		git.establish_Origin_repo("folder", credentials)
        end
    end
		
	describe ".commit_andPush" do
        it("commits and pushes changes") do
			git = GithubModifier.new()
			git.commit_andPush("x")
		end
    end
	describe ".removeFiles_addSubmodule" do
        it("removes files and adds submodule") do
			allow($stdin).to receive(:gets).and_return('login2','pass2')
			credentials = {
				user: 'login1',
				pass: 'pass1'
			}
			git = GithubModifier.new()
			git.removeFiles_addSubmodule("x", credentials)
			$stdin.gets
		end
    end
	

	describe ".delete_online_repo" do
        it("deletes online repository") do
			credentials = {
				user: 'login1',
				pass: 'pass1'
			}
			git = GithubModifier.new()
			git.delete_online_repo("folder", credentials)
		end
    end
	describe ".create_online_repo" do
        it("creates online repository") do
			credentials = {
				user: 'login1',
				pass: 'pass1'
			}
			git = GithubModifier.new()
			git.create_online_repo("folder", credentials)
		end
    end
	describe ".check_online_repo" do
        it("checks online repository") do
			credentials = {
				user: 'login1',
				pass: 'pass1'
			}
			git = GithubModifier.new()
			git.check_online_repo("folder", credentials)
		end
    end
	
	describe ".create_Repo_From_subFolder" do
		it("creating repository failed") do
			git = GithubModifier.new()
			credentials = {
				user: 'login1',
				pass: 'pass1'
			}
			allow(git).to receive(:create_online_repo).and_return(true)
			allow(git).to receive(:check_online_repo).and_return(false)
			allow(git).to receive(:establish_Origin_repo).and_return(true)
			git.create_Repo_From_subFolder("folder", credentials)
		end
		it("creating repository succeded") do
			git = GithubModifier.new()
			credentials = {
				user: 'login1',
				pass: 'pass1'
			}
			allow(git).to receive(:create_online_repo).and_return(true)
			allow(git).to receive(:check_online_repo).and_return(true)
			git.create_Repo_From_subFolder("folder", credentials)
		end
	end

end