require 'fileutils'
require_relative("../app/src/prior_mapped")
RSpec.describe Prior_Mapped do
    describe ".unset_remove_submodulized" do
        it("changes directory and removes .submodulized file") do
            FileUtils.mkdir_p '../dir1/dir2'
            File.open("../dir1/dir2/.submodulized", "w") { |f| 
                f.write("write your stuff here")
                prior_mapped = Prior_Mapped.new()
                prior_mapped.unset_remove_submodulized("dir1", "dir2")
                expect(File.exist?("../dir1/dir2/.submodulized")).to eq(false)
            }
            FileUtils.rm_rf('../dir1')
        end
        it("throws error if file doesn't exist") do
            FileUtils.rm_rf('../dir1')
            prior_mapped = Prior_Mapped.new()
            expect { prior_mapped.unset_remove_submodulized("dir1", "dir2") }.to raise_error
        end
    end

    describe ".check_submodulized" do
        it("returns true if file .submodulized exists") do
            FileUtils.mkdir_p '../dir1/dir2'
            File.open("../dir1/dir2/.submodulized", "w") { |f| 
                f.write("write your stuff here")
                prior_mapped = Prior_Mapped.new()
                output = prior_mapped.check_submodulized("dir1", "dir2")
                expect(output).to eq(true)
            }
            FileUtils.rm_rf('../dir1')
        end
        it("returns false if file .submodulized doesn't exists") do
            FileUtils.mkdir_p '../dir1/dir2'
            prior_mapped = Prior_Mapped.new()
            output = prior_mapped.check_submodulized("dir1", "dir2")
            expect(output).to eq(false)
            FileUtils.rm_rf('../dir1')
        end
    end

    describe ".set_touch_submodulized" do
        it("creates .submodulized file") do
            FileUtils.mkdir_p '../dir1/dir2'
            File.open("../dir1/dir2/.submodulized", "w") { |f| 
                f.write("write your stuff here")
                prior_mapped = Prior_Mapped.new()
                output = prior_mapped.set_touch_submodulized("dir1", "dir2")
                expect(File.exist?("../dir1/dir2/.submodulized")).to eq(true)
            }
            FileUtils.rm_rf('../dir1')
        end
    end
end