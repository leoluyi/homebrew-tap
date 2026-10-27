class B64split < Formula
  desc "Split files into size-limited Base64 text parts"
  homepage "https://github.com/leoluyi/b64split"
  url "https://github.com/leoluyi/b64split.git",
      tag:      "v0.1.1",
      revision: "d04404f9dbaa42093d967eb0918a68a7a652d227"
  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", "-ldflags=-s -w",
           "-o", "#{bin}/b64split", "."
  end

  test do
    input = testpath/"input.bin"
    input.write("test")
    parts = testpath/"parts"

    system bin/"b64split", "--max-size", "4", "--output-dir", parts, input

    assert_equal "dGVz", (parts/"part-0001.b64.txt").read
    assert_equal "dA==", (parts/"part-0002.b64.txt").read
  end
end
