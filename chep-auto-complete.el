;;; chep-auto-complete.el --- use semantic to create on the fly yas snippets
;;
;; Filename: chep-auto-complete.el
;; Description: use semantic to create on the fly yas snippets
;; Author: Cédric Chépied <cedric.chepied@gmail.com>
;; Maintainer: Cédric Chépied
;; Copyright (C) 2013, Cédric Chépied
;; Last updated: Sat Aug 31 13:30 UTC
;;     By Cédric Chépied
;;     Update 1
;; Keywords: auto complete taf function
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;; Yas snippets can be created on the fly to perform a smart completion
;; Currently there is only one possible completion.
;;
;; chep-auto-function adds a snippet for function arguments. Just move
;; point after last character of the function you want to complete and
;; call chep-auto-function.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;; Copyright Cédric Chépied 2013
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'semantic/analyze/complete)

(defun chep-auto-function()
  (interactive)
  (let ((tag (semantic-analyze-possible-completions-default (semantic-analyze-current-context))))
    (if (and tag (string= "function" (semantic-tag-class (car tag))))
        (progn (let ((arg-list (semantic-tag-function-arguments (car tag)))
                     (snippet "(")
                     (i 1))
                 (dolist (arg arg-list)
                   (setq snippet (concat snippet "${"
                                         (number-to-string i)
                                         ":"
                                         (car arg)
                                         "}, ")
                         i (1+ i)))
                 (setq snippet (substring snippet 0 -2))
                 (yas-expand-snippet (concat snippet ")$0")
                                     (point)
                                     (point)
                                     nil))))))



(provide 'chep-auto-complete)
