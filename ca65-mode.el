;;; ca65-mode.el --- Major mode for the ca65 assembler -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2020 DESKTOP-T8EC56E
;;
;; Author: DESKTOP-T8EC56E <http://github/root>
;; Maintainer: DESKTOP-T8EC56E <root@DESKTOP-T8EC56E>
;; Created: September 20, 2020
;; Modified: September 20, 2020
;; Version: 0.0.1
;; Keywords: languages
;; Homepage: https://github.com/root/ca65-mode
;; Package-Requires: ((emacs "27.2"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Major mode for the ca65 assembler
;;
;;; Code:


;; create the list for font-lock.
;; each category of keyword is given a particular face
(defvar ca65-mode-font-lock-keywords)
(setq ca65-mode-font-lock-keywords
      (let* (
            ;; define several category of keywords
            (x-opcodes '("ADC" "AND" "ASL" "BCC" "BCS" "BEQ" "BIT" "BMI" "BNE" "BPL" "BRK" "BVC" "BVS" "CLC" "CLD" "CLI" "CLV" "CMP" "CPX" "CPY" "DEC" "DEX" "DEY" "EOR" "INC" "INX" "INY" "JMP" "JSR" "LDA" "LDX" "LDY" "LSR" "NOP" "ORA" "PHA" "PHP" "PLA" "PLP" "ROL" "ROR" "RTI" "RTS" "SBC" "SEC" "SED" "SEI" "STA" "STX" "STY" "TAX" "TAY" "TSX" "TXA" "TXS" "TYA"))

            ;; generate regex string for each category of keywords
            (x-labels-regexp "^\s*[a-z0-9_]*:")
            (x-opcodes-regexp (regexp-opt x-opcodes 'words))
            (x-directives-regexp "\\.[a-z0-9_]*")
            (x-variable-regexp "[a-z0-9_]*")
            (x-constant-regexp "[#$%<>]\\{1,2\\}[0-9a-f]*")
         )
        `(
          ;(,x-types-regexp . font-lock-type-face)
          (,x-directives-regexp . font-lock-preprocessor-face)
          (,x-labels-regexp . font-lock-keyword-face)
          (,x-opcodes-regexp . font-lock-function-name-face)
          (,x-constant-regexp . font-lock-constant-face)
          (,x-variable-regexp . font-lock-variable-name-face)
          ;; note: order above matters, because once colored, that part won't change.
          ;; in general, put longer words first
          )))

(defvar ca65-mode-syntax-table)
(setq ca65-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        ;; python style comment: “# …”
        (modify-syntax-entry ?\; "<" synTable)
        (modify-syntax-entry ?\n ">" synTable)
        synTable))

;;;###autoload
(define-derived-mode ca65-mode prog-mode "ca65"
  "Major mode for editing ca65 assembler source files"

  ;; code for syntax highlighting
  (setq font-lock-defaults '((ca65-mode-font-lock-keywords) nil t))
  ;; code for commenting
  (setq-local comment-start "; ")
  (setq-local comment-end ""))

(provide 'ca65-mode)
;;; ca65-mode.el ends here
