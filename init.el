;; # ----------------------
;; # 初期読込
;; # ----------------------
;; Emacs23以下は、user-emacs-directory変数が未定義のため次の設定を追加
(when (< emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d/"))

;; サブディレクトリも load-path に追加する関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf")

;; package.elの設定
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; init-loaderの設定
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf")

;; auto-installの設定
;; (ELPAに無い物やURL指定、EmacsWikiからもインストールできるように)
(require 'auto-install)
(auto-install-compatibility-setup)

;; # ----------------------
;; # キーバインドの割当
;; # ----------------------
;; "C-m" で改行＋インデント
(define-key global-map (kbd "C-m") 'newline-and-indent)

;; "C-c l" で折り返し切り替え
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)

;; "C-t" でウィンドウを切り替える。初期値はtranspose-chars
(define-key global-map (kbd "C-t") 'other-window)

;; # ----------------------
;; # 初期設定
;; # ----------------------
;;クリップボードを有効
(cond (window-system
  (setq x-select-enable-clipboard t)
  ))

;; ウィンドウサイズの位置、サイズ
(if window-system (progn
  (setq initial-frame-alist '((width . 105)(height . 80)(top . 0)(left . 0)))
  (set-background-color "Black")
  (set-foreground-color "White")
  (set-cursor-color "Gray")
))

;;環境変数追加
(add-to-list 'exec-path "/opt/local/bin")
(add-to-list 'exec-path "/usr/local/bin")

;; 文字コードを指定する
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; Mac OS Xの場合のファイル名の設定
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

;; Windowsの場合のファイル名の設定
(when (eq window-system 'w32)
  (set-file-name-coding-system 'cp932)
  (setq locale-coding-system 'cp932))

;; カラム番号も表示
(column-number-mode t)

;; ファイルサイズを表示
(size-indication-mode t)

;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")

;; TABの表示幅。初期値は8
(setq-default tab-width 4)

;; バックアップとオートセーブファイルを~/.emacs.d/backups/へ集める
(add-to-list 'backup-directory-alist
   (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
   `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))

;; デフォルトのカラーテーマから指定
(load-theme 'wombat t)

;; 現在行のハイライト
;; (global-hl-line-mode t)

;; # ----------------------
;; # 拡張機能設定
;; # ----------------------
;; auto-complete設定
(require 'auto-complete-config)
(ac-config-default)
;;(add-to-list 'ac-modes 'text-mode) ;; text-modeでも自動的に有効にする
;;(ac-set-trigger-key "TAB")
;;(setq ac-use-menu-map t) ;; 補完メニュー表示時にC-n/C-pで補完候補選択
;;(setq ac-use-fuzzy t) ;; 曖昧マッチ

;; ruby-mode設定
(autoload 'ruby-mode "ruby-mode"
   "Mode for editing ruby source files" t)
   (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
   (add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
   (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
   (add-to-list 'auto-mode-alist '("[Rr]akefile$" . ruby-mode))

;; ruby-block設定
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(size-indication-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )