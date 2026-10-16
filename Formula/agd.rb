class Agd < Formula
  desc "An org-agenda for the terminal and for coding agents"
  homepage "https://github.com/johnnybravo-xyz/agd"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.2.0/agd-aarch64-apple-darwin.tar.xz"
      sha256 "e8c8bd43dd3bbdccadde5c4fb5ff07ad55e1c590a6b0d556eb29d53c69267b78"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.2.0/agd-x86_64-apple-darwin.tar.xz"
      sha256 "e4db71c4829775c95f4a98ce50e1cca5bcd5528fa4e83910971a9c7ba0176c3f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.2.0/agd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f31de07c5370462ad0ad8a823ca78a9146f82241bffb81c774e8dc579f2a8504"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.2.0/agd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f92bd59c82fe39316ab9c113d714bd8c7eee821e99e6b935a39606325dd27ec2"
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
