Facter.add("php_version") do
  setcode do
    Facter::Util::Resolution.exec('php-config --version')    || nil
  end
end
