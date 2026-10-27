class B64split < Formula
  desc "Split files into size-limited Base64 text parts"
  homepage "https://github.com/leoluyi/b64split"
  url "https://github.com/leoluyi/b64split.git",
      tag: "v0.1.0",
      revision: "d1ffa4dbea8cdcf92fbb3224f2933eb75b230e74"
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

    assert_equal "dGVz", (parts/"part-0001.b64").read
    assert_equal "dA==", (parts/"part-0002.b64").read
  end
end
