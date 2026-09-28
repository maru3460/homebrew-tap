# url / sha256 / version の 3 行は md-preview のリリース CI が書き換える。
# 行の形（先頭 2 スペース + キーワード）を変えると書き換えが効かなくなる。
class MdPreview < Formula
  desc "Markdown ファイルを macOS のネイティブウィンドウで表示するツール"
  homepage "https://github.com/maru3460/md-preview"
  url "https://github.com/maru3460/md-preview/releases/download/v0.2.0/md-preview-v0.2.0-macos-universal.tar.gz"
  sha256 "6dc520fa1ad442efb824b74703acdb405c3fe365a5ae3137f62461be4f96f6e2"
  # url からも同じ版が読み取れるので brew audit --strict は redundant と言うが、
  # ファイル名の付け方を変えたときに黙って別の版として扱われる方が怖いので明示する。
  version "0.2.0"
  license "MIT"

  depends_on :macos

  def install
    bin.install "md"
  end

  def caveats
    <<~EOS
      md は設定とキャッシュを ~/.config と ~/Library の下に置きます。
      brew はそれらに触らないので、消すときは先に

        md uninstall

      を実行してから brew uninstall md-preview してください。
      順番が逆だと md uninstall が打てなくなります。
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/md --version")
  end
end
