APP_NAME = Rails.root.to_s.split(/\//).last
PKG_DIR = File.join(Rails.root, 'pkg')
VERSION = File.exist?('VERSION') ? File.read('VERSION').strip : ""

desc "Release the app"
task :release do
  mkdir PKG_DIR unless File.exists?(PKG_DIR) && File.directory?(PKG_DIR)
  tmp_dir = "#{PKG_DIR}/#{APP_NAME}"
  system("rm -fr #{tmp_dir}")
  system("git clone #{Rails.root} #{tmp_dir}")

  puts "Create the src release..."
  system("rm -fr #{tmp_dir}/.git")
  system("rm -fr #{tmp_dir}/.gitignore")
  system("cd #{PKG_DIR};tar czf #{APP_NAME}-#{VERSION}.src.tar.gz #{APP_NAME}")
  puts "Create the bin release..."
  system("bundle package")
  system("mv #{Rails.root}/vendor/cache #{tmp_dir}/vendor")
  system("cd #{PKG_DIR};tar czf #{APP_NAME}-#{VERSION}.bin.tar.gz #{APP_NAME}")
  system("rm -fr #{tmp_dir}")
  puts "#{APP_NAME} #{VERSION} released!"
end
