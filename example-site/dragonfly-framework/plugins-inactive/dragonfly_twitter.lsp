;;  Copyright (C) <2009> <Marc Hildmann>
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU General Public License for more details.
;;  You should have received a copy of the GNU General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;; @module Dragonfly Twitter search plugin
;; @author Marc Hildmann <marc.hildmann at gmail.com>
;; @version taoeffect
;; 
;; @location http://code.google.com/p/dragonfly-newlisp/
;; @description A newLISP web framework for rapid web development
;; <h4>About Dragonfly web framework</h4>
;; <p>Dragonfly is a small web framework which is currently under heavy development.
;; Its's features are a short learning curve, lightweight and fun in programming - 
;; just like newLISP itself.</p>

;===============================================================================
; !Loading plugin into Dragonfly context
;===============================================================================

(DF:activate-plugin "twitter-oauth")
;; (module "twitter-oauth.lsp")
;; (load "plugins-inactive/twitter-oauth.lsp")
(context 'Dragonfly)

;===============================================================================
; !twitter functions
;===============================================================================

;; @syntax (Dragonfly:twitter-search <keyword> <max-items>)
;; @param <keyword> string containing the keyword for search
;; @param <max-items> INTEGER, maximum of items you want to show
;; <p>Writes the results of a Twitter search.</p>

(define (twitter-search keyword max-items)
  (set 'base-url "https://api.twitter.com/1.1/search/tweets.json")
  (set 'query (list (list "count" max-items) (list "q" keyword)))
  (set 'jsp (Oauth:get-tweets base-url query))
  (setq jsp (lookup "statuses" jsp))
  (dolist (i jsp)
    (println
     "<div class='entry'>"
     "<div class='headline'>" (lookup "text" i) "</div><br/>"
     "<div class='published'>" (lookup "created_at" i) "</div><div class='author'>By&nbsp;" (lookup "screen_name" (lookup "user" i)) "</div><br/>"
     "</div>"
    )
  )
)

(context MAIN)
