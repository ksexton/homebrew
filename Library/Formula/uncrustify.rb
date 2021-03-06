class Uncrustify < Formula
  homepage "http://uncrustify.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/uncrustify/uncrustify/uncrustify-0.61/uncrustify-0.61.tar.gz"
  sha1 "711f6f081e596aa7e162b6035997d5e2eed2f49a"

  head "https://github.com/bengardner/uncrustify.git"

  bottle do
    cellar :any
    sha1 "82e6f950648e0a04411e84a563ff96a50b2b8efc" => :yosemite
    sha1 "9040d701020412937138be6e1521d136d44961b3" => :mavericks
    sha1 "999421447b999f73f5850e3275e5f47775e0cc27" => :mountain_lion
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"t.c").write <<-EOS.undent
      #include <stdio.h>
      int main(void) {return 0;}
    EOS
    expected = <<-EOS.undent
      #include <stdio.h>
      int main(void) {
      \treturn 0;
      }
    EOS

    system "#{bin}/uncrustify", "-c", "#{share}/uncrustify/defaults.cfg", "t.c"
    assert_equal expected, File.read("#{testpath}/t.c.uncrustify")
  end
end
