class Agd < Formula
  desc "An org-agenda for the terminal and for coding agents"
  homepage "https://github.com/johnnybravo-xyz/agd"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.2.0/agd-aarch64-apple-darwin.tar.xz"
      sha256 "9b94982b46b295ddef1c87064b922ae70d7af3fc7002c4d5727cd02d86803ce0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.2.0/agd-x86_64-apple-darwin.tar.xz"
      sha256 "df12eb48b14127c2a0da82039d8ec755984cd3157b5518934d237b249f5d882a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.2.0/agd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "17a24fdf2883a86712972982cb12d6893e189e4e806c05edce405df3257dec09"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.2.0/agd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b78a07e4efa880f3fa2c8e0a0b21d05c422ec79604fbe6c62907c3e08a1d9031"
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
