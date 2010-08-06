require 'formula'

class Restkit <Formula
  url 'git://github.com/benoitc/restkit.git'
  homepage 'http://benoitc.github.com/restkit'
  version '2.1.1'
  @spec = {:tag => '2.1.1'}

  depends_on 'distribute'

  def install

    python = Formula.factory("python")
    unless python.installed?
      onoe "The \"couchapp\" brew is only meant to be used against a Homebrew-built Python."
      puts <<-EOS
        Homebrew's "couchapp" formula is only meant to be installed against a Homebrew-
        built version of Python, but we couldn't find such a version.

        The system-provided Python comes with "easy_install" already installed, with the
        caveat that some Python packages don't install cleanly against Apple's customized
        versions of Python.

        To install couchapp against a custom Python:
        First install pip:
          $ curl -O http://python-distribute.org/distribute_setup.py
          $ sudo python distribute_setup.py
          $ easy_install pip
          
        Then install latest released couchapp:
          $ pip install restkit

        Or latest development:
          $ pip install git+http://github.com/benoitc/benoitc.git#egg=restkit

      EOS
      exit 99
    end

    system "#{python.bin}/python", "setup.py", "install",
              "--install-scripts", bin,
              "--install-purelib", python.site_packages,
              "--install-platlib", python.site_packages

    (prefix+"README.homebrew").write <<-EOF
couchapp's libraries were installed directly into:
    #{python.site_packages}
EOF
  end

  def caveats
    <<-EOS.undent
      This formula is only meant to be used against a Homebrew-built Python.
      It will install itself directly into Python's location in the Cellar.
    EOS
  end
end
