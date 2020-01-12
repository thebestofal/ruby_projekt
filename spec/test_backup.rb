require_relative("../app/src/backup")
RSpec.describe Backups do

  describe ".submodule_backup" do
    it "do fresh backup" do
      FileUtils.mkdir_p '../dir1/folder'
      expect(Dir.exist?('../dir1/submodulebackup_folder')).to be false
      Backups.submodule_backup('dir1', 'folder')
      expect(Dir.exist?('../dir1/submodulebackup_folder')).to be true
      FileUtils.rm_rf("../dir1")
    end
    it("replace existing folder") do
      FileUtils.mkdir_p '../dir1/submodulebackup_folder'
      FileUtils.mkdir_p '../dir1/folder/inside'
      expect(Dir.exist?('../dir1/submodulebackup_folder/inside')).to be false
      Backups.submodule_backup('dir1', 'folder')
      expect(Dir.exist?('../dir1/submodulebackup_folder/inside')).to be true
      FileUtils.rm_rf("../dir1")
    end
  end

  describe ".Backup" do
    it "do fresh backup" do
      FileUtils.mkdir_p '../dir1'
      FileUtils.mkdir_p '../dir1/folder'
      FileUtils.touch('sample_file.txt')
      expect(Dir.exist?'../dir1/backup_folder').to be false
      expect {
        Backups.Backup('dir1', 'folder')
      }.to output("Backup of folder created in dir1.\n").to_stdout
      expect(Dir.exist?'../dir1/backup_folder').to be true
      FileUtils.rm_rf("../dir1")
    end
    it "ignore backup if copy already exists" do
      FileUtils.mkdir_p '../dir1/backup_folder'
      FileUtils.mkdir_p '../dir1/folder'
      FileUtils.touch('sample_file.txt')
      expect{
        Backups.Backup('dir1', 'folder')
      }.to_not output.to_stdout
      expect(Dir.exist?'../dir1/backup_folder').to be true
      FileUtils.rm_rf("../dir1")
    end
  end

  describe ".Delete_Backup" do
    it "delete backup folder" do
      FileUtils.mkdir_p '../dir1/backup_folder'
      Backups.Delete_Backup('dir1', 'folder')
      expect(Dir.exist?'../dir1/backup_folder').to be false
    end
    it "not existing backup" do
      FileUtils.mkdir_p'../dir1'
      expect(Dir.exist?('../dir1/backup_folder')).to be false
      Backups.Delete_Backup('dir1', 'folder')
      expect(Dir.exist?('../dir1/backup_folder')).to be false
      FileUtils.rm_rf("../dir1")
    end
  end

  describe ".directory" do
    it "check existing directory" do
      FileUtils.mkdir_p'../dir1/'
      dir = Backups.directory('dir1')
      expect(dir).to eq("../dir1/")
      FileUtils.rm_rf("../dir1")
    end
    it "check not existing directory" do
      dir = Backups.directory('dir1')
      expect(dir).to eq("dir1")
    end

  end

end
