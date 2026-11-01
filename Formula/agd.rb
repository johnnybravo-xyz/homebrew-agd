class Agd < Formula
  desc "An org-agenda for the terminal and for coding agents"
  homepage "https://github.com/johnnybravo-xyz/agd"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.3.0/agd-aarch64-apple-darwin.tar.xz"
      sha256 "92a739018f12c0fcfd63b5de364f18a97d963b4c393f083542d9bf564eb5b75a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.3.0/agd-x86_64-apple-darwin.tar.xz"
      sha256 "86877468bbce9ad8a0811b7da0d4fb2bd9364a71ae5fd7ab3015289f60d201ba"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.3.0/agd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0df3e432596327209a5fe878b75d6965dc1ae8c4007642e5388dbb172bf4dfbb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.3.0/agd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eaa8686b1e4a237c98d6ee5c5e15a49f8e3517b0b27663ec98c73ce85d61d9f6"
    end
  end
  license "GPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "agd"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "agd"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "agd"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "agd"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
