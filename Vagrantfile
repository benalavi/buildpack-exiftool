# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "lucid64"
  config.vm.box_url = "http://files.vagrantup.com/lucid64.box"
  
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--name", "buildpack-exiftool", "--memory", "512"]
  end
  
  config.vm.provision "shell", inline: <<-EOS
if [ ! -x "/usr/bin/git" ];then
  echo "Installing git"
  
  apt-get update -qq
  apt-get install -y git-core
fi

version=2.0.0-p247
alt=`echo $version | sed -e "s/-.*//g" -e "s/\\.//g"`

if [ ! -x "/usr/bin/ruby$version" ]; then
  echo "Installing ruby $version"
  
	apt-get update -qq
	apt-get install -y build-essential autoconf libxslt1.1 libssl-dev \
    libxslt1-dev libxml2 libffi-dev libyaml-dev libxslt-dev libc6-dev \
    libreadline6-dev zlib1g-dev libcurl4-openssl-dev ncurses-dev

  cd /tmp
  wget ftp://ftp.ruby-lang.org/pub/ruby/2.0/ruby-$version.tar.gz -O ruby-$version.tar.gz
  tar xvf ruby-$version.tar.gz
  cd ruby-$version
  autoconf
  ./configure --with-ruby-version=$version --prefix=/usr \
    --program-suffix=$version --disable-install-doc --with-opt-dir=/usr/include
  make
  make install-nodoc
  update-alternatives \
    --install /usr/bin/ruby ruby /usr/bin/ruby$version $alt \
    --slave /usr/bin/erb erb /usr/bin/erb$version \
    --slave /usr/bin/irb irb /usr/bin/irb$version \
    --slave /usr/bin/rdoc rdoc /usr/bin/rdoc$version \
    --slave /usr/bin/ri ri /usr/bin/ri$version \
    --slave /usr/bin/rake rake /usr/bin/rake$version \
    --slave /usr/bin/testrb testrb /usr/bin/testrb$version
  update-alternatives --install /usr/bin/gem gem /usr/bin/gem$version $alt
  update-alternatives --config ruby
  update-alternatives --config gem
fi

gem list bundler | grep bundler ||
  gem install bundler --no-rdoc --no-ri

cd /vagrant && bundle install

echo 'Done.'
EOS
end
