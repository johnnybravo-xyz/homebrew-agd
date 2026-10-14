class Agd < Formula
  desc "Local-first CLI and stdio MCP server for org-mode files"
  homepage "https://github.com/johnnybravo-xyz/agd"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.1.0/agd-aarch64-apple-darwin.tar.xz"
      sha256 "022afeb6828564a7d5ab36750c260eb2930a46ce8dd97d583c6801f0ee27fe2d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.1.0/agd-x86_64-apple-darwin.tar.xz"
      sha256 "73e78b8171d94a1c73bc9e7c642826e2ded1275025d34257d8414415bab01980"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.1.0/agd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3a00c8e99b6828725d8c2ab03b818c5ddccaa9c00b2e6920dc0ff861c5b29425"
    end
    if Hardware::CPU.intel?
      url "https://github.com/johnnybravo-xyz/agd/releases/download/v0.1.0/agd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d1a2b1a2781a943ca8fc87a4173776c69478e6fefc9389ac1490cb370798e88c"
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
