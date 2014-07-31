;;; init. el
;(load-theme 'misterioso t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/zenburn-theme-20140613.207")
(load-theme 'zenburn t)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)


;; auto-complete
;; 補完自動表示
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.emacs.d/auto-complete/lib/popup")
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)

;; anzu
;; 検索時、(1/20)のように個数と何番目かを表示
(global-anzu-mode +1)

;; smooth-scroll
;; スクロールをスムーズにしてくれる
;(require 'smooth-scroll)
;(smooth-scroll-mode t)

;; magit
;; git クライアント
(require 'magit)

;; 画面移動
(global-set-key (kbd "C-c C-b") 'windmove-left)
(global-set-key (kbd "C-c C-n") 'windmove-down)
(global-set-key (kbd "C-c C-p") 'windmove-up)
(global-set-key (kbd "C-c C-f") 'windmove-right)

;; powerline
;; ステータスバーの見た目をかっちょよくする
(require 'powerline)
(powerline-default-theme)

;; diminish
;; ステータスバー表示をカスタマイズ
(require 'diminish)
(diminish 'anzu-mode)
(diminish 'undo-tree-mode)
(diminish 'auto-complete-mode)
(diminish 'smartparens-mode)

;; rainbow delimiters
;; 対応するカッコを色付けし見やすくする
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode t)

;; 対応するカッコをハイライト
(show-paren-mode t)

;; melpa
;; パッケージインストール用サイト

;; emacs-nav
;; 左にナビゲーション追加
(add-to-list 'load-path "~/.emacs.d/emacs-nav")
(require 'nav)
(global-set-key (kbd "C-x C-d") 'nav-toggle)
(custom-set-variables '(nav-width 12))

;; flycheck
;; 静的構文解釈
;(add-to-list 'load-path "~/.emacs.d/flycheck")
(require 'flycheck)
;(setq flycheck-check-syntax-automatically '(mode-enabled save))
(add-hook 'after-init-hook #'global-flycheck-mode)
;(add-hook 'ruby-mode-hook 'flycheck-mode)


;; migemo
;; 日本語でも検索
(add-to-list 'load-path "/Users/takuji/.emacs.d/cmigemo")
;(require 'migemo)
(setq migemo-dictionary "/Users/takuji/.emacs.d/cmigemo/dict/utf-8.d/migemo-dict")
(setq migemo-command "/usr/local/bin/cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-user-dictionary nil)
(setq migemo-coding-system 'utf-8)
(setq migemo-regex-dictionary nil)
(load-library "migemo")
(migemo-init)




;; タイトルバーにファイル名を表示
(setq frame-title-format (format "%%f - emacs@%s " (system-name)))

;; helmの設定（anything後継）
(add-to-list 'load-path "~/.emacs.d/helm")
(require 'helm-config)
(global-set-key (kbd "C-;") 'helm-mini)

;; Javascriptモード
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; smartparens
;; カッコの自動挿入
(require 'smartparens-config)
(smartparens-global-mode t)

;; gtags
;; タグ付けにより、ソースコードを行ったり来たり
(require 'helm-gtags)
(add-hook 'c-mode-hook 'helm-gtags-mode)
;; key bindings
(add-hook 'helm-gtags-mode-hook
         '(lambda ()
             (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
             (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
             (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
             (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)))

;; 行数の表示
;; 行数のハイライト
(add-to-list 'load-path "~/.emacs.d/hlinum-mode")
(require 'hlinum)
(global-linum-mode t)
(hlinum-activate)
(global-hl-line-mode)
(setq linum-format "%4d")
(setq linum-delay t)

;; undo-tree
;; 編集履歴の見える化
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "C-_") 'undo-tree-redo)

;; auto-installの設定
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install/"))
(require 'auto-install)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;; フォントの設定
(create-fontset-from-ascii-font "Menlo-14:weight=normal:slant=normal" nil "menlokakugo")
(set-fontset-font "fontset-menlokakugo"
                  'unicode
                  (font-spec :family "Hiragino Kaku Gothic ProN" :size 13)
                  nil
                  'append)
(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))


(setq inhibit-splash-screen t)



;;; タブ幅の設定
(setq default-tab-width 2)


;; c/c++/java/php style
(defun c-mode-common-hooks ()
 (when (eq system-type 'windows-nt)
   ;(c-set-style "bsd")
	(c-set-style "k&r")
   (setq c-basic-offset 2)
   (setq indent-tabs-mode t))
 ;; hungry-delete
 (c-toggle-hungry-state 1)
 ;; _と-も単語の一部とみなす(区切らない)
 (modify-syntax-entry ?_ "w" c-mode-syntax-table)
 ;; (modify-syntax-entry ?- "w" c-mode-syntax-table) ; アロー演算子
(->)の-が単語の一部と解釈されてしまう
 )
(add-hook 'c-mode-common-hook 'c-mode-common-hooks)


;(require 'elscreen)

;; バックアップファイルを以下の場所に作成
(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))

(display-time)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 行と桁の表示
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(line-number-mode t)
(column-number-mode t)
;; 選択範囲の情報表示
(defun count-lines-and-chars ()
 (if mark-active
     (format "[%3d:%4d]"
             (count-lines (region-beginning) (region-end))
             (- (region-end) (region-beginning)))
   ""))
(add-to-list 'default-mode-line-format
            '(:eval (count-lines-and-chars)))

(provide 'init)
;;; init.el ends here
