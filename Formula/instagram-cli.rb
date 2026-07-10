class InstagramCli < Formula
  desc "Unofficial CLI and terminal client for Instagram"
  homepage "https://github.com/supreme-gg-gg/instagram-cli"
  url "https://registry.npmjs.org/@i7m/instagram-cli/-/instagram-cli-2.0.1.tgz"
  sha256 "80e83d6093daa27fa3b0683db2fceff3adddc18f695253ede6fa909a0a5f1bb8"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args

    # Homebrew 5.1.0+ disables postinstall hooks in https://github.com/Homebrew/brew/pull/21136
    # Here we will run the postinstall script directly to patch packages
    pkg_root = libexec/"lib/node_modules/@i7m/instagram-cli"
    Dir.chdir(pkg_root) do
      system "node", "node_modules/patch-package/index.js"
    end

    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/instagram-cli --version")
  end
end
