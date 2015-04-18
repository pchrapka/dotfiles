;;;;;;;;;;;;;;;;;;
;;
;; Org mode
;;
;;;;;;;;;;;;;;;;;;

;;(add-to-list 'load-path (expand-file-name "~/git/org-mode/lisp"))

;; Add contributions folder
(add-to-list 'load-path (expand-file-name "~/projects/org-mode/contrib/lisp"))


;; Open up all org files
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))


;;Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;Habit Tracking
; Enable habit tracking (and a bunch of other modules)
(setq org-modules (quote (org-bbdb
                          org-bibtex
                          org-crypt
                          org-gnus
                          org-id
                          org-info
                          org-habit
                          org-inlinetask
                          org-irc
                          org-mhe
                          org-protocol
                          org-rmail
                          org-w3m)))

; position the habit graph on the agenda to the right of the default
(setq org-habit-graph-column 50)

;;Agenda
(setq org-agenda-files (quote ("~/projects/org"
			       "~/projects/research-notebook")))

;; Custom Key Bindings
(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "<f5>") 'bh/org-todo)
(global-set-key (kbd "<S-f5>") 'bh/widen)
(global-set-key (kbd "<f7>") 'bh/set-truncate-lines)
(global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
(global-set-key (kbd "<f9> <f9>") 'bh/show-org-agenda)
(global-set-key (kbd "<f9> b") 'bbdb)
(global-set-key (kbd "<f9> c") 'calendar)
(global-set-key (kbd "<f9> f") 'boxquote-insert-file)
(global-set-key (kbd "<f9> g") 'gnus)
(global-set-key (kbd "<f9> h") 'bh/hide-other)
(global-set-key (kbd "<f9> n") 'org-narrow-to-subtree)
(global-set-key (kbd "<f9> w") 'widen)
(global-set-key (kbd "<f9> u") 'bh/narrow-up-one-level)

(global-set-key (kbd "<f9> I") 'bh/punch-in)
(global-set-key (kbd "<f9> O") 'bh/punch-out)

(global-set-key (kbd "<f9> o") 'bh/make-org-scratch)

(global-set-key (kbd "<f9> r") 'boxquote-region)
(global-set-key (kbd "<f9> s") 'bh/switch-to-scratch)

(global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)
(global-set-key (kbd "<f9> T") 'tabify)
(global-set-key (kbd "<f9> U") 'untabify)

(global-set-key (kbd "<f9> v") 'visible-mode)
(global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)
(global-set-key (kbd "C-<f9>") 'previous-buffer)
(global-set-key (kbd "M-<f9>") 'org-toggle-inline-images)
(global-set-key (kbd "C-x n r") 'narrow-to-region)
(global-set-key (kbd "C-<f10>") 'next-buffer)
(global-set-key (kbd "<f11>") 'org-clock-goto)
(global-set-key (kbd "C-<f11>") 'org-clock-in)
(global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)
(global-set-key (kbd "C-M-r") 'org-capture)
(global-set-key (kbd "C-c r") 'org-capture)

(defun bh/hide-other ()
  (interactive)
  (save-excursion
    (org-back-to-heading 'invisible-ok)
    (hide-other)
    (org-cycle)
    (org-cycle)
    (org-cycle)))

(defun bh/set-truncate-lines ()
  "Toggle value of truncate-lines and refresh window display."
  (interactive)
  (setq truncate-lines (not truncate-lines))
  ;; now refresh window display (an idiom from simple.el):
  (save-excursion
    (set-window-start (selected-window)
                      (window-start (selected-window)))))

(defun bh/make-org-scratch ()
  (interactive)
  (find-file "/tmp/publish/scratch.org")
  (gnus-make-directory "/tmp/publish"))

(defun bh/switch-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))

;;Tasks and States
;;TODO Keywords
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "STARTED(s!)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE"))))

;;(setq org-todo-keyword-faces
;;      (quote (("TODO" :foreground "red" :weight bold)
;;              ("NEXT" :foreground "blue" :weight bold)
;;              ("DONE" :foreground "forest green" :weight bold)
;;              ("WAITING" :foreground "orange" :weight bold)
;;              ("HOLD" :foreground "magenta" :weight bold)
;;              ("CANCELLED" :foreground "forest green" :weight bold)
;;              ("PHONE" :foreground "forest green" :weight bold))))

(setq org-todo-keyword-faces
    '(("TODO" :background "red1" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
      ("NEXT" :background "red1" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
      ("STARTED" :background "orange" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
      ("WAITING" :background "yellow" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
      ("HOLD" :background "gray" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
      ("DONE" :background "forest green" :weight bold :box (:line-width 2 :style released-button))
      ("CANCELLED" :background "lime green" :foreground "black" :weight bold :box (:line-width 2 :style released-button))))

;;      ("PROJ" :background "blue" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
;;      ("APPT" :background "red1" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
;;      ("DEFERRED" :background "gold" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
;;      ("DELEGATED" :background "gold" :foreground "black" :weight bold :box (:line-width 2 :style released-button))

;;Fast Todo Selection
(setq org-use-fast-todo-selection t)

(setq org-treat-S-cursor-todo-selection-as-state-change nil)

;;TODO State Triggers
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING" . t) ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("STARTED" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

;;Org Capture
(setq org-directory "~/projects/org")
(setq org-default-notes-file "~/projects/org/refile.org")

;; I use C-M-r to start capture mode
(global-set-key (kbd "C-M-r") 'org-capture)
;; I use C-c r to start capture mode when using SSH from my Android phone
(global-set-key (kbd "C-c r") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/projects/org/refile.org")
               "* TODO Entry%?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("n" "note" entry (file "~/projects/org/refile.org")
               "* Entry%? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("i" "idea" entry (file "~/projects/org/sparkfile.org")
               "* Entry%? :IDEA:\n%U\n%a\n" :clock-in t :clock-resume t)
	      ("j" "Journal Entries")
              ("jp" "Personal Journal Entry" entry (file+datetree "~/projects/org/journal.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
	      ("jr" "Research Journal Entry" entry (file+headline "~/projects/research-notebook/research-notebook.org" "Inbox")
               "* Entry%?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/projects/org/refile.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("h" "Habit" entry (file "~/projects/org/refile.org")
               "* NEXT Entry%? :habit:\nSCHEDULED: %t .+1d/3d\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n%U\n%a\n")
	      ("g" "Getting results")
	      ("gm" "Monday Vision" entry (file+datetree "~/projects/org/journal.org")
               (file "~/projects/org/templates/mondayvision.tmplt") :clock-in t :clock-resume t)
	      ("gd" "Daily Outcomes" entry (file+datetree "~/projects/org/journal.org")
               (file "~/projects/org/templates/dailyoutcomes.tmplt") :clock-in t :clock-resume t)
	      ("gb" "Big Win" entry (file+datetree "~/projects/org/journal.org")
               (file "~/projects/org/templates/bigwin.tmplt") :clock-in t :clock-resume t)
	      ("gf" "Friday Reflection" entry (file+datetree "~/projects/org/journal.org")
               (file "~/projects/org/templates/fridayreflection.tmplt") :clock-in t :clock-resume t)
	      ("r" "Templates for reviews")
	      ("rh" "Home Review" entry (file+datetree "~/projects/org/journal.org")
               (file "~/projects/org/templates/homereview.tmplt") :clock-in t :clock-resume t)
	      ("rd" "Daily Review" entry (file+datetree "~/projects/org/journal.org")
               (file "~/projects/org/templates/dailyreview.tmplt") :clock-in t :clock-resume t)
	      ("rw" "Weekly Review" entry (file+datetree "~/projects/org/journal.org")
               (file "~/projects/org/templates/weeklyreview.tmplt") :clock-in t :clock-resume t)
	      ("rm" "Monthly Review" entry (file+datetree "~/projects/org/journal.org")
               (file "~/projects/org/templates/monthlyreview.tmplt") :clock-in t :clock-resume t)
	      ("rq" "Quarterly Review" entry (file+datetree "~/projects/org/journal.org")
               (file "~/projects/org/templates/quarterlyreview.tmplt") :clock-in t :clock-resume t)
	      ("ry" "Yearly Review" entry (file+datetree "~/projects/org/journal.org")
               (file "~/projects/org/templates/yearlyreview.tmplt") :clock-in t :clock-resume t)
	      ("rp" "Project Review" entry (file "~/projects/org/refile.org")
	       (file "~/projects/org/templates/review.tmplt") :clock-in t :clock-resume t)
	      ("s" "School")
	      ("sl" "Lab" entry (file "~/projects/org/refile.org")
	       (file "~/projects/org/templates/lab.tmplt") :clock-in t :clock-resume t)
	      ("l" "Life")
	      ("lr" "Rebalance Portforlio" entry (file+headline "~/projects/org/personal.org" "Financial" "Investments")
               (file "~/projects/org/templates/rebalance.tmplt") :clock-in t :clock-resume t)
	      )))

;;  	      ("p" "Research paper" entry (file+headline "~/projects/org/researchjournal.org" "Reading") (file "~/projects/org/templates/paper.tmplt") :clock-in t :clock-resume t)


;;Refiling Tasks
; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

;;Custom Agenda Views
;; Dim blocked tasks
(setq org-agenda-dim-blocked-tasks t)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

(defun pc/org-agenda-skip-tag (tag &optional others)
  "Skip all entries that correspond to TAG."
  "If OTHERS is true, skip all entries that do not correspond to TAG."
  (let ((next-headline (save-excursion (or (outline-next-heading) (point-max))))
        (current-headline (or (and (org-at-heading-p)
                                   (point))
                              (save-excursion (org-back-to-heading)))))
    (if others
        (if (not (member tag (org-get-tags-at current-headline)))
            next-headline
          nil)
      (if (member tag (org-get-tags-at current-headline))
          next-headline
        nil))))

(defun pc/skip-project-tag (tag)
  "Show tasks related to the current restriction."
  "Skip projects and tasks corresponding to TAG"
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
           (next-headline (save-excursion (or (outline-next-heading) (point-max))))
	   (current-headline (or (and (org-at-heading-p)
				      (point))
				 (save-excursion (org-back-to-heading)))))
      (cond
       ((bh/is-project-p)
        next-headline)
       ((and (not (member tag (org-get-tags-at current-headline))))
	next-headline)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))
              ("h" "Habits" tags-todo "STYLE=\"habit\""
               ((org-agenda-overriding-header "Habits")
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))

              ("g" "Getting Results" 
               ((tags-todo "quarterlypriority-someday-REFILE-CANCELLED/!-HOLD"
                 ((org-agenda-overriding-header "Quarterly Priorities")
		  (org-agenda-skip-function 'bh/skip-habits)
		  (org-tags-match-list-sublevels t)
		  (org-agenda-sorting-strategy
                  '(priority-down effort-up))))
		(tags-todo "monthlypriority-someday-REFILE-CANCELLED/!-HOLD"
                 ((org-agenda-overriding-header "Monthly Priorities")
		  (org-agenda-skip-function 'bh/skip-habits)
		  (org-tags-match-list-sublevels t)
		  (org-agenda-sorting-strategy
                  '(priority-down effort-up))))
		(tags-todo "+thisweek" 
			   ((org-agenda-overriding-header "Monday Vision")
			    (org-agenda-sorting-strategy
			     '(priority-down effort-up))))
		(tags-todo "+dailyoutcome"
			   ((org-agenda-overriding-header "Daily Outcomes")
			    (org-agenda-sorting-strategy
			     '(priority-down effort-up))))
		(agenda "" 
			((org-agenda-span 7)
			 (org-agenda-start-day "-7d")
			 (org-agenda-start-on-weekday nil)
			 (org-agenda-show-log t)
			 (org-agenda-skip-function 
			  '(org-agenda-skip-entry-if 'notregexp ":dailyoutcome:"))))
		(tags-todo "+changes"
			   ((org-agenda-overriding-header "Changes")
			    (org-agenda-sorting-strategy
			     '(priority-down effort-up))))))
	      (" " . "Agendas")
              ("  " "Agenda"
               ((agenda "" nil)
                (tags "REFILE"
                      ((org-agenda-overriding-header "Tasks to Refile")
                       (org-tags-match-list-sublevels nil)))
		(tags-todo "dailyoutcome-REFILE-CANCELLED/!-HOLD"
		 ((org-agenda-overriding-header "Daily Outcomes")
		  (org-agenda-skip-function 'bh/skip-habits)
                  (org-tags-match-list-sublevels t)
                  (org-agenda-sorting-strategy
                   '(priority-down effort-up))))
                (tags-todo "thisweek-someday-REFILE-CANCELLED/!-HOLD"
                 ((org-agenda-overriding-header "Weekly Vision")
		  (org-agenda-skip-function 'bh/skip-habits)
                  (org-tags-match-list-sublevels t)
                  (org-agenda-sorting-strategy
                   '(priority-down effort-up))))
                (tags-todo "monthlypriority-someday-REFILE-CANCELLED/!-HOLD"
                 ((org-agenda-overriding-header "Monthly Priorities")
		  (org-agenda-skip-function 'bh/skip-habits)
                  (org-tags-match-list-sublevels t)
                  (org-agenda-sorting-strategy
                   '(priority-down effort-up))))
                (tags-todo "-someday-CANCELLED/!"
                           ((org-agenda-overriding-header "Stuck Projects")
                            (org-agenda-skip-function 'bh/skip-non-stuck-projects)))
                (tags-todo "-someday-WAITING-CANCELLED/!STARTED"
                           ((org-agenda-overriding-header "Started Tasks")
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(priority-down effort-up))))
                (tags-todo "-someday-WAITING-CANCELLED/!NEXT|STARTED"
                           ((org-agenda-overriding-header "Next Tasks")
                            (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(priority-down effort-up))))
                (tags-todo "-goal-someday-REFILE-CANCELLED/!-HOLD-WAITING"
                           ((org-agenda-overriding-header "Tasks")
                            (org-agenda-skip-function 'bh/skip-project-tasks-maybe)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-agenda-sorting-strategy
                             '(priority-down effort-up))))
                (tags-todo "-someday-CANCELLED+WAITING-HOLD/!-HOLD"
                           ((org-agenda-overriding-header "Waiting Tasks")
                            (org-agenda-skip-function 'bh/skip-stuck-projects)
                            (org-tags-match-list-sublevels nil)
                            (org-agenda-todo-ignore-scheduled 'future)
                            (org-agenda-todo-ignore-deadlines 'future)))
                (tags "-REFILE/"
                      ((org-agenda-overriding-header "Tasks to Archive")
                       (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                       (org-tags-match-list-sublevels nil))))
	       nil)
	      (" c" "Compact Agenda"
	       ((agenda "" nil))
               ((org-agenda-filter-preset '("-morning" "-evening" "-drphil"))))
	      (" s" "School Agenda"
	       ((agenda "" 
			((org-agenda-skip-function '(pc/org-agenda-skip-tag "drphil" 't))))
		(tags-todo "dailyoutcome-REFILE-CANCELLED/!-HOLD"
			   ((org-agenda-overriding-header "Daily Outcomes")
			    (org-agenda-skip-function 'bh/skip-habits)
			    (org-tags-match-list-sublevels t)
			    (org-agenda-sorting-strategy
			     '(priority-down effort-up))))
                (tags-todo "thisweek-REFILE-CANCELLED/!-HOLD"
			   ((org-agenda-overriding-header "Weekly Vision")
			    (org-agenda-skip-function 'bh/skip-habits)
			    (org-tags-match-list-sublevels t)
			    (org-agenda-sorting-strategy
			     '(priority-down effort-up))))
                (tags-todo "monthlypriority+drphil-learning-someday-REFILE-CANCELLED/!-HOLD"
			   ((org-agenda-overriding-header "Monthly Priorities")
			    (org-agenda-skip-function 'bh/skip-habits)
			    (org-tags-match-list-sublevels t)
			    (org-agenda-sorting-strategy
			     '(priority-down effort-up))))
                (tags-todo "+drphil-learning-someday-CANCELLED/!"
                           ((org-agenda-overriding-header "Stuck Projects")
                            (org-agenda-skip-function 'bh/skip-non-stuck-projects)))
                (tags-todo "+drphil-learning-someday-WAITING-CANCELLED/!STARTED"
                           ((org-agenda-overriding-header "Started Tasks")
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(priority-down effort-up))))
                (tags-todo "+drphil-reading-to_read-learning-someday-WAITING-CANCELLED/!NEXT|STARTED"
                           ((org-agenda-overriding-header "Next Tasks")
                            (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(priority-down effort-up))))
                (tags-todo "+drphil-reading-to_read-goal-learning-someday-REFILE-CANCELLED/!-HOLD-WAITING"
                           ((org-agenda-overriding-header "Tasks")
                            (org-agenda-skip-function 'bh/skip-project-tasks-maybe)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-agenda-sorting-strategy
                             '(priority-down effort-up))))
                (tags-todo "+drphil-learning-goal-someday-REFILE-CANCELLED/!-HOLD-WAITING"
                           ((org-agenda-overriding-header "Reading List")
			    (org-agenda-skip-function '(pc/skip-project-tag "reading"))
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-agenda-sorting-strategy
                             '(priority-down effort-up))))
                (tags-todo "+drphil-goal-learning-someday-CANCELLED+WAITING-HOLD/!-HOLD"
                           ((org-agenda-overriding-header "Waiting Tasks")
                            (org-agenda-skip-function 'bh/skip-stuck-projects)
                            (org-tags-match-list-sublevels nil)
                            (org-agenda-todo-ignore-scheduled 'future)
                            (org-agenda-todo-ignore-deadlines 'future)))
		)
	       ;; remove all entries with the learning tag from the school agenda view
	       ((org-agenda-filter-preset '("-learning")))
	       )
	      (" l" "Learning Agenda"
	       ((agenda "" 
			((org-agenda-skip-function '(pc/org-agenda-skip-tag "learning" 't))))
                (tags-todo "+learning-someday-CANCELLED/!"
                           ((org-agenda-overriding-header "Stuck Projects")
                            (org-agenda-skip-function 'bh/skip-non-stuck-projects)))
                (tags-todo "+learning-someday-WAITING-CANCELLED/!STARTED"
                           ((org-agenda-overriding-header "Started Tasks")
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(priority-down effort-up))))
                (tags-todo "-reading-to_read+learning-someday-WAITING-CANCELLED/!NEXT|STARTED"
                           ((org-agenda-overriding-header "Next Tasks")
                            (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(priority-down effort-up))))
                (tags-todo "-reading-to_read-goal+learning-someday-REFILE-CANCELLED/!-HOLD-WAITING"
                           ((org-agenda-overriding-header "Tasks")
                            (org-agenda-skip-function 'bh/skip-project-tasks-maybe)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-agenda-sorting-strategy
                             '(priority-down effort-up))))
                (tags-todo "+learning-goal-someday-REFILE-CANCELLED/!-HOLD-WAITING"
                           ((org-agenda-overriding-header "Reading List")
			    (org-agenda-skip-function '(pc/skip-project-tag "reading"))
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-agenda-sorting-strategy
                             '(priority-down effort-up))))
                (tags-todo "-goal+learning-someday-CANCELLED+WAITING-HOLD/!-HOLD"
                           ((org-agenda-overriding-header "Waiting")
                            (org-agenda-skip-function 'bh/skip-stuck-projects)
                            (org-tags-match-list-sublevels nil)
                            (org-agenda-todo-ignore-scheduled 'future)
                            (org-agenda-todo-ignore-deadlines 'future)))
                (tags-todo "+learning-someday-HOLD-CANCELLED/!"
                           ((org-agenda-overriding-header "Projects")
                            (org-agenda-skip-function 'bh/skip-non-projects)
                            (org-agenda-sorting-strategy
                             '(priority-down effort-up))))
		)
	       )
	      ("r" . "Reviews")
              ("rm" "Mornings"
               ((agenda "" nil))
               ((org-agenda-filter-preset '("+morning"))))
              ("re" "Evenings"
               ((agenda "" nil))
               ((org-agenda-filter-preset '("+evening"))))
              ("rd" "Reviews"
               ((agenda "" nil))
               ((org-agenda-filter-preset '("+reviews"))))
	      ("i" . "Tasks")
              ("in" "Next Tasks" tags-todo "-someday-WAITING-CANCELLED/!NEXT|STARTED"
               ((org-agenda-overriding-header "Next Tasks")
                (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                (org-agenda-todo-ignore-scheduled t)
                (org-agenda-todo-ignore-deadlines t)
                (org-agenda-todo-ignore-with-date t)
                (org-tags-match-list-sublevels t)
                (org-agenda-sorting-strategy
                 '(priority-down effort-up))))
              ("it" "Tasks" tags-todo "-goal-someday-REFILE-CANCELLED/!-HOLD-WAITING"
               ((org-agenda-overriding-header "Tasks")
                (org-agenda-skip-function 'bh/skip-project-tasks-maybe)
                (org-agenda-sorting-strategy
                 '(priority-down effort-up))))
              ("iw" "Waiting Tasks" tags-todo "-someday-CANCELLED+WAITING/!"
               ((org-agenda-overriding-header "Waiting and Postponed tasks"))
               (org-tags-match-list-sublevels nil))
              ("ia" "Tasks to Archive" tags "-REFILE/"
               ((org-agenda-overriding-header "Tasks to Archive")
                (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                (org-tags-match-list-sublevels nil)))
	      ("p" . "Projects")
	      ("ps" "Stuck Projects" tags-todo "-someday-CANCELLED/!"
               ((org-agenda-overriding-header "Stuck Projects")
                (org-agenda-skip-function 'bh/skip-non-stuck-projects)))
              ("pp" "Projects" tags-todo "-someday-HOLD-CANCELLED/!"
               ((org-agenda-overriding-header "Projects")
                (org-agenda-skip-function 'bh/skip-non-projects)
                (org-agenda-sorting-strategy
                 '(priority-down effort-up))))
              ("d" "Priorities" 
               ((tags-todo "dailypriority-someday-REFILE-CANCELLED/!-HOLD"
                ((org-agenda-overriding-header "Daily Priorities")
		 (org-agenda-skip-function 'bh/skip-habits)
                 (org-tags-match-list-sublevels t)
                 (org-agenda-sorting-strategy
                  '(priority-down effort-up))))
                (tags-todo "weeklypriority-someday-REFILE-CANCELLED/!-HOLD"
                 ((org-agenda-overriding-header "Weekly Priorities")
		  (org-agenda-skip-function 'bh/skip-habits)
		  (org-tags-match-list-sublevels t)
		  (org-agenda-sorting-strategy
                  '(priority-down effort-up))))
                (tags-todo "monthlypriority-someday-REFILE-CANCELLED/!-HOLD"
                 ((org-agenda-overriding-header "Monthly Priorities")
		  (org-agenda-skip-function 'bh/skip-habits)
		  (org-tags-match-list-sublevels t)
		  (org-agenda-sorting-strategy
                  '(priority-down effort-up))))
               (tags-todo "quarterlypriority-someday-REFILE-CANCELLED/!-HOLD"
                 ((org-agenda-overriding-header "Quarterly Priorities")
		  (org-agenda-skip-function 'bh/skip-habits)
		  (org-tags-match-list-sublevels t)
		  (org-agenda-sorting-strategy
                  '(priority-down effort-up))))))
              ("c" "Contexts" 
               (
		(tags-todo "@school-someday-REFILE-CANCELLED/!-HOLD"
		 ((org-agenda-overriding-header "@School")
                 (org-agenda-skip-function 'bh/skip-projects-and-habits-2)
                 (org-tags-match-list-sublevels t)
                 (org-agenda-sorting-strategy
                  '(priority-down effort-up))))
		(tags-todo "@wingate-someday-REFILE-CANCELLED/!-HOLD"
		 ((org-agenda-overriding-header "@Wingate")
                 (org-agenda-skip-function 'bh/skip-projects-and-habits-2)
                 (org-tags-match-list-sublevels t)
                 (org-agenda-sorting-strategy
                  '(priority-down effort-up))))
		(tags-todo "@home-someday-REFILE-CANCELLED/!-HOLD"
		 ((org-agenda-overriding-header "@Home")
                 (org-agenda-skip-function 'bh/skip-projects-and-habits-2)
                 (org-tags-match-list-sublevels t)
                 (org-agenda-sorting-strategy
                  '(priority-down effort-up))))
                (tags-todo "@shopping-someday-REFILE-CANCELLED/!-HOLD"
                 ((org-agenda-overriding-header "@Shopping")
                 (org-agenda-skip-function 'bh/skip-projects-and-habits-2)
                 (org-tags-match-list-sublevels t)
                 (org-agenda-sorting-strategy
                  '(priority-down effort-up))))
                (tags-todo "@errand-someday-REFILE-CANCELLED/!-HOLD"
                 ((org-agenda-overriding-header "@Errand")
                 (org-agenda-skip-function 'bh/skip-projects-and-habits-2)
                 (org-tags-match-list-sublevels t)
                 (org-agenda-sorting-strategy
                  '(priority-down effort-up))))
                (tags-todo "@tms-someday-REFILE-CANCELLED/!-HOLD"
                 ((org-agenda-overriding-header "@The Music Stand")
                 (org-agenda-skip-function 'bh/skip-projects-and-habits-2)
                 (org-tags-match-list-sublevels t)
                 (org-agenda-sorting-strategy
                  '(priority-down effort-up))))))
              ("o" "People" 
               (
		(tags-todo "@asia-someday-REFILE-CANCELLED/!-HOLD"
                ((org-agenda-overriding-header "Asia")
                 (org-agenda-skip-function 'bh/skip-projects-and-habits-2)
                 (org-tags-match-list-sublevels t)
                 (org-agenda-sorting-strategy
                  '(priority-down effort-up))))
		(tags-todo "@debruin-someday-REFILE-CANCELLED/!-HOLD"
                 ((org-agenda-overriding-header "de Bruin")
                  (org-agenda-skip-function 'bh/skip-projects-and-habits-2)
                  (org-tags-match-list-sublevels t)
                  (org-agenda-sorting-strategy
                   '(priority-down effort-up))))
		(tags-todo "@reilly-someday-REFILE-CANCELLED/!-HOLD"
                 ((org-agenda-overriding-header "Reilly")
                  (org-agenda-skip-function 'bh/skip-projects-and-habits-2)
                  (org-tags-match-list-sublevels t)
                  (org-agenda-sorting-strategy
                   '(priority-down effort-up))))
		(tags-todo "@kaziu-someday-REFILE-CANCELLED/!-HOLD"
                ((org-agenda-overriding-header "Kaziu")
                 (org-agenda-skip-function 'bh/skip-projects-and-habits-2)
                 (org-tags-match-list-sublevels t)
                 (org-agenda-sorting-strategy
                  '(priority-down effort-up))))
                (tags-todo "@wiesia-someday-REFILE-CANCELLED/!-HOLD"
                 ((org-agenda-overriding-header "Wiesia")
                  (org-agenda-skip-function 'bh/skip-projects-and-habits-2)
                  (org-tags-match-list-sublevels t)
                  (org-agenda-sorting-strategy
                   '(priority-down effort-up))))
		))
	      )))

(defun bh/org-auto-exclude-function (tag)
  "Automatic task exclusion in the agenda with / RET"
  (and (cond
        ((string= tag "hold")
         t)
        ((string= tag "freetime")
	  t)
	((string= tag "projectreview")
	  t)
        ((string= tag "review")
	  t)
	((string= tag "volunteer")
	  t)
	((string= tag "someday")
	  t))
       (concat "-" tag)))

(setq org-agenda-auto-exclude-function 'bh/org-auto-exclude-function)

(setq org-tags-exclude-from-inheritance 
      (quote ("lifearea"
	      "lifegoal"
	      "10yeargoal"
	      "5yeargoal"
	      "1yeargoal"
	      "2014goal"
	      "quarterlypriority"
	      "monthlypriority"
	      "weeklypriority"
	      "goal"
	      )))

;;Clocking
;;
;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)
;;
;; Show lot sof clocking history so it's easy to pick items off the C-F11 list
(setq org-clock-history-length 36)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Change tasks to NEXT when clocking in
(setq org-clock-in-switch-to-state 'bh/clock-in-to-next)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

(setq bh/keep-clock-running nil)

(defun bh/clock-in-to-next (kw)
  "Switch a task from TODO or NEXT to STARTED when clocking in.
Skips capture tasks, projects, and subprojects.
Switch projects and subprojects from NEXT back to TODO"
  (when (not (and (boundp 'org-capture-mode) org-capture-mode))
    (cond
     ((and (member (org-get-todo-state) (list "TODO"))
           (bh/is-task-p))
      "STARTED")
     ((and (member (org-get-todo-state) (list "NEXT"))
           (bh/is-task-p))
      "STARTED")
     ((and (member (org-get-todo-state) (list "NEXT"))
           (bh/is-project-p))
      "TODO"))))

(defun bh/find-project-task ()
  "Move point to the parent (project) task if any"
  (save-restriction
    (widen)
    (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
      (while (org-up-heading-safe)
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq parent-task (point))))
      (goto-char parent-task)
      parent-task)))

(defun bh/punch-in (arg)
  "Start continuous clocking and set the default task to the
selected task.  If no task is selected set the Organization task
as the default task."
  (interactive "p")
  (setq bh/keep-clock-running t)
  (if (equal major-mode 'org-agenda-mode)
      ;;
      ;; We're in the agenda
      ;;
      (let* ((marker (org-get-at-bol 'org-hd-marker))
             (tags (org-with-point-at marker (org-get-tags-at))))
        (if (and (eq arg 4) tags)
            (org-agenda-clock-in '(16))
          (bh/clock-in-organization-task-as-default)))
    ;;
    ;; We are not in the agenda
    ;;
    (save-restriction
      (widen)
      ; Find the tags on the current task
      (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
          (org-clock-in '(16))
        (bh/clock-in-organization-task-as-default)))))

(defun bh/punch-out ()
  (interactive)
  (setq bh/keep-clock-running nil)
  (when (org-clock-is-active)
    (org-clock-out))
  (org-agenda-remove-restriction-lock))

(defun bh/clock-in-default-task ()
  (save-excursion
    (org-with-point-at org-clock-default-task
      (org-clock-in))))

(defun bh/clock-in-parent-task ()
  "Move point to the parent (project) task if any and clock in"
  (let ((parent-task))
    (save-excursion
      (save-restriction
        (widen)
        (while (and (not parent-task) (org-up-heading-safe))
          (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
            (setq parent-task (point))))
        (if parent-task
            (org-with-point-at parent-task
              (org-clock-in))
          (when bh/keep-clock-running
            (bh/clock-in-default-task)))))))

(defvar bh/organization-task-id "df205245-e73f-4740-af83-017c5ba53c62")

(defun bh/clock-in-organization-task-as-default ()
  (interactive)
  (org-with-point-at (org-id-find bh/organization-task-id 'marker)
    (org-clock-in '(16))))

(defun bh/clock-out-maybe ()
  (when (and bh/keep-clock-running
             (not org-clock-clocking-in)
             (marker-buffer org-clock-default-task)
             (not org-clock-resolving-clocks-due-to-idleness))
    (bh/clock-in-parent-task)))

(add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)
(setq org-time-stamp-rounding-minutes (quote (1 1)))

(setq org-agenda-clock-consistency-checks
      (quote (:max-duration "4:00"
              :min-duration 0
              :max-gap 0
              :gap-ok-around ("4:00"))))


;;Time Reporting and Tracking
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Agenda clock report parameters
(setq org-agenda-clockreport-parameter-plist
      (quote (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80)))

; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%50ITEM(Task) %1PRIORITY %4Effort(Effort){:} %4CLOCKSUM %10TAGS")

; global Effort estimate values
; global STYLE property values for completion
(setq org-global-properties 
      (quote (("Effort_ALL" . "0:05 0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
	      ("STYLE_ALL" . "habit"))))

;; Agenda log mode items to display (closed and state changes by default)
(setq org-agenda-log-mode-items (quote (state)))

;;Tags
; Tags with fast selection keys
;; TODO set these
;; (setq org-tag-alist (quote ((:startgroup)
;;                             ("@errand" . ?e)
;;                             ("@office" . ?o)
;;                             ("@home" . ?H)
;;                             ("@farm" . ?f)
;;                             (:endgroup)
;;                             ("PHONE" . ?p)
;;                             ("WAITING" . ?w)
;;                             ("HOLD" . ?h)
;;                             ("PERSONAL" . ?P)
;;                             ("WORK" . ?W)
;;                             ("FARM" . ?F)
;;                             ("ORG" . ?O)
;;                             ("NORANG" . ?N)
;;                             ("crypt" . ?E)
;;                             ("MARK" . ?M)
;;                             ("NOTE" . ?n)
;;                             ("BZFLAG" . ?B)
;;                             ("CANCELLED" . ?c)
;;                             ("FLAGGED" . ??))))

; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)

; Default priority
(setq org-default-priority ?C)

;;GTD
(setq org-agenda-span 'day)
(setq org-stuck-projects (quote ("" nil nil "")))

(defun bh/is-project-p ()
  "Any task with a todo keyword subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task has-subtask))))

(defun bh/is-project-subtree-p ()
  "Any task with a todo keyword that is in a project subtree.
Callers of this function already widen the buffer view."
  (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
                              (point))))
    (save-excursion
      (bh/find-project-task)
      (if (equal (point) task)
          nil
        t))))

(defun bh/is-task-p ()
  "Any task with a todo keyword and no subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task (not has-subtask)))))

(defun bh/is-subproject-p ()
  "Any task which is a subtask of another project"
  (let ((is-subproject)
        (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
    (save-excursion
      (while (and (not is-subproject) (org-up-heading-safe))
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq is-subproject t))))
    (and is-a-task is-subproject)))

(defun bh/list-sublevels-for-projects-indented ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels 'indented)
    (setq org-tags-match-list-sublevels nil))
  nil)

(defun bh/list-sublevels-for-projects ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels t)
    (setq org-tags-match-list-sublevels nil))
  nil)

(defun bh/skip-stuck-projects ()
  "Skip trees that are not stuck projects"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (bh/is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                nil
              next-headline)) ; a stuck project, has subtasks but no next task
        nil))))

(defun bh/skip-non-stuck-projects ()
  "Skip trees that are not stuck projects"
  (bh/list-sublevels-for-projects-indented)
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (bh/is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                next-headline
              nil)) ; a stuck project, has subtasks but no next task
        next-headline))))

(defun bh/skip-non-projects ()
  "Skip trees that are not projects"
  (bh/list-sublevels-for-projects-indented)
  (if (save-excursion (bh/skip-non-stuck-projects))
      (save-restriction
        (widen)
        (let ((subtree-end (save-excursion (org-end-of-subtree t))))
          (cond
           ((and (bh/is-project-p)
                 (marker-buffer org-agenda-restrict-begin))
            nil)
           ((and (bh/is-project-p)
                 (not (marker-buffer org-agenda-restrict-begin))
                 (not (bh/is-project-subtree-p)))
            nil)
           (t
            subtree-end))))
    (save-excursion (org-end-of-subtree t))))

(defun bh/skip-project-trees-and-habits ()
  "Skip trees that are projects"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))

(defun bh/skip-projects-and-habits-and-single-tasks ()
  "Skip trees that are projects, tasks that are habits, single non-project tasks"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((org-is-habit-p)
        next-headline)
       ((bh/is-project-p)
        next-headline)
       ((and (bh/is-task-p) (not (bh/is-project-subtree-p)))
        next-headline)
       (t
        nil)))))

;; My Code
(defun bh/skip-projects-and-habits-2 ()
  "Skip tasks that are projects and tasks that are habits"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((org-is-habit-p)
        next-headline)
       ((bh/is-project-p)
        next-headline)
       (t
        nil)))))

(defun bh/skip-habits ()
  "Skip tasks that are habits"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((org-is-habit-p)
        next-headline)
       (t
        nil)))))

(defun bh/skip-project-tasks-maybe ()
  "Show tasks related to the current restriction.
When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
When not restricted, skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
           (next-headline (save-excursion (or (outline-next-heading) (point-max))))
           (limit-to-project (marker-buffer org-agenda-restrict-begin)))
      (cond
       ((bh/is-project-p)
        next-headline)
       ((org-is-habit-p)
        subtree-end)
       ((and (not limit-to-project)
             (bh/is-project-subtree-p))
        subtree-end)
       ((and limit-to-project
             (bh/is-project-subtree-p)
             (member (org-get-todo-state) (list "NEXT")))
        subtree-end)
       (t
        nil)))))

(defun bh/skip-projects-and-habits ()
  "Skip trees that are projects and tasks that are habits"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))

(defun bh/skip-non-subprojects ()
  "Skip trees that are not projects"
  (let ((next-headline (save-excursion (outline-next-heading))))
    (if (bh/is-subproject-p)
        nil
      next-headline)))

;;Archiving
(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive::* Archived Tasks")

(defun bh/skip-non-archivable-tasks ()
  "Skip trees that are not available for archiving"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      ;; Consider only tasks with done todo headings as archivable candidates
      (if (member (org-get-todo-state) org-done-keywords)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (daynr (string-to-int (format-time-string "%d" (current-time))))
                 (a-month-ago (* 60 60 24 (+ daynr 1)))
                 (last-month (format-time-string "%Y-%m-" (time-subtract (current-time) (seconds-to-time a-month-ago))))
                 (this-month (format-time-string "%Y-%m-" (current-time)))
                 (subtree-is-current (save-excursion
                                       (forward-line 1)
                                       (and (< (point) subtree-end)
                                            (re-search-forward (concat last-month "\\|" this-month) subtree-end t)))))
            (if subtree-is-current
                next-headline ; Has a date in this month or last month, skip it
              nil))  ; available to archive
        (or next-headline (point-max))))))


;;Reminders
; Erase all reminders and rebuilt reminders for today from the agenda
(defun bh/org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))

; Rebuild the reminders everytime the agenda is displayed
(add-hook 'org-finalize-agenda-hook 'bh/org-agenda-to-appt 'append)

; This is at the end of my .emacs - so appointments are set up when Emacs starts
(bh/org-agenda-to-appt)

; Activate appointments so we get notifications
(appt-activate t)

; If we leave Emacs running overnight - reset the appointments one minute after midnight
(run-at-time "24:01" nil 'bh/org-agenda-to-appt)

;;Productivity

;Narrowing To A Subtree With
(global-set-key (kbd "<f5>") 'bh/org-todo)

(defun bh/org-todo (arg)
  (interactive "p")
  (if (equal arg 4)
      (save-restriction
        (bh/narrow-to-org-subtree)
        (org-show-todo-tree nil))
    (bh/narrow-to-org-subtree)
    (org-show-todo-tree nil)))

(global-set-key (kbd "<S-f5>") 'bh/widen)

(defun bh/widen ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (org-agenda-remove-restriction-lock)
    (widen)
    (org-agenda-remove-restriction-lock)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "W" 'bh/widen))
          'append)

(defun bh/restrict-to-file-or-follow (arg)
  "Set agenda restriction to 'file or with argument invoke follow mode.
I don't use follow mode very often but I restrict to file all the time
so change the default 'F' binding in the agenda to allow both"
  (interactive "p")
  (if (equal arg 4)
      (org-agenda-follow-mode)
    (if (equal major-mode 'org-agenda-mode)
        (bh/set-agenda-restriction-lock 4)
      (widen))))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "F" 'bh/restrict-to-file-or-follow))
          'append)

(defun bh/narrow-to-org-subtree ()
  (widen)
  (org-narrow-to-subtree)
  (save-restriction
    (org-agenda-set-restriction-lock)))

(defun bh/narrow-to-subtree ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (org-with-point-at (org-get-at-bol 'org-hd-marker)
        (bh/narrow-to-org-subtree))
    (bh/narrow-to-org-subtree)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "N" 'bh/narrow-to-subtree))
          'append)

(defun bh/narrow-up-one-org-level ()
  (widen)
  (save-excursion
    (outline-up-heading 1 'invisible-ok)
    (bh/narrow-to-org-subtree)))

(defun bh/get-pom-from-agenda-restriction-or-point ()
  (or (org-get-at-bol 'org-hd-marker)
      (and (marker-position org-agenda-restrict-begin) org-agenda-restrict-begin)
      (and (equal major-mode 'org-mode) (point))
      org-clock-marker))

(defun bh/narrow-up-one-level ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (org-with-point-at (bh/get-pom-from-agenda-restriction-or-point)
        (bh/narrow-up-one-org-level))
    (bh/narrow-up-one-org-level)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "U" 'bh/narrow-up-one-level))
          'append)

(defun bh/narrow-to-org-project ()
  (widen)
  (save-excursion
    (bh/find-project-task)
    (bh/narrow-to-org-subtree)))

(defun bh/narrow-to-project ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (org-with-point-at (bh/get-pom-from-agenda-restriction-or-point)
        (bh/narrow-to-org-project))
    (bh/narrow-to-org-project)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "P" 'bh/narrow-to-project))
          'append)

(defvar bh/current-view-project nil)

(defun bh/view-next-project ()
  (interactive)
  (unless (marker-position org-agenda-restrict-begin)
    (goto-char (point-min))
    (setq bh/current-view-project (point)))
  (bh/widen)
  (goto-char bh/current-view-project)
  (forward-visible-line 1)
  (while (and (< (point) (point-max))
              (or (not (org-get-at-bol 'org-hd-marker))
                  (org-with-point-at (org-get-at-bol 'org-hd-marker)
                    (or (not (bh/is-project-p))
                        (bh/is-project-subtree-p)))))
    (forward-visible-line 1))
  (setq bh/current-view-project (point))
  (if (org-get-at-bol 'org-hd-marker)
      (bh/narrow-to-project)
    (message "All projects viewed.")
    (ding)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "V" 'bh/view-next-project))
          'append)

(setq org-show-entry-below (quote ((default))))

;Limiting The Agenda To A Subtree
(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "\C-c\C-x<" 'bh/set-agenda-restriction-lock))
          'append)

(defun bh/set-agenda-restriction-lock (arg)
  "Set restriction lock to current task subtree or file if prefix is specified"
  (interactive "p")
  (let* ((pom (bh/get-pom-from-agenda-restriction-or-point))
         (tags (org-with-point-at pom (org-get-tags-at))))
    (let ((restriction-type (if (equal arg 4) 'file 'subtree)))
      (save-restriction
        (cond
         ((and (equal major-mode 'org-agenda-mode) pom)
          (org-with-point-at pom
            (org-agenda-set-restriction-lock restriction-type)))
         ((and (equal major-mode 'org-mode) (org-before-first-heading-p))
          (org-agenda-set-restriction-lock 'file))
         (pom
          (org-with-point-at pom
            (org-agenda-set-restriction-lock restriction-type))))))))


;;Tuning The Agenda Views

;Highlight The Current Agenda Line
;; Always hilight the current agenda line
(add-hook 'org-agenda-mode-hook
          '(lambda () (hl-line-mode 1))
          'append)
;; The following custom-set-faces create the highlights


;;Keep Tasks With Timestamps Visible On The Global Todo Lists

;; Keep tasks with dates on the global todo lists
(setq org-agenda-todo-ignore-with-date nil)

;; Keep tasks with deadlines on the global todo lists
(setq org-agenda-todo-ignore-deadlines nil)

;; Keep tasks with scheduled dates on the global todo lists
(setq org-agenda-todo-ignore-scheduled nil)

;; Keep tasks with timestamps on the global todo lists
(setq org-agenda-todo-ignore-timestamp nil)

;; Remove completed deadline tasks from the agenda view
(setq org-agenda-skip-deadline-if-done t)

;; Remove completed scheduled tasks from the agenda view
(setq org-agenda-skip-scheduled-if-done t)

;; Remove completed items from search results
(setq org-agenda-skip-timestamp-if-done t)

;;Use The Diary For Holidays And Appointments
(setq org-agenda-include-diary nil)
(setq org-agenda-diary-file "~/projects/org/journal.org")

(setq org-agenda-insert-diary-extract-time t)

;;Searches Include Archive Files
;; Include agenda archive files when searching for things
(setq org-agenda-text-search-extra-files (quote (agenda-archives)))

;;Agenda View Tweaks

;; Show all future entries for repeating tasks
(setq org-agenda-repeating-timestamp-show-all t)

;; Show all agenda dates - even if they are empty
(setq org-agenda-show-all-dates t)

;; Sorting order for tasks on the agenda
(setq org-agenda-sorting-strategy
      (quote ((agenda habit-down time-up user-defined-up priority-down effort-up category-keep)
              (todo category-up priority-down effort-up)
              (tags category-up priority-down effort-up)
              (search category-up))))

;; Start the weekly agenda on Monday
(setq org-agenda-start-on-weekday 1)

;; Enable display of the time grid so we can see the marker for the current time
(setq org-agenda-time-grid (quote ((daily today remove-match)
                                   #("----------------" 0 16 (org-heading t))
                                   (830 1000 1200 1300 1500 1700))))

;; Display tags farther right
(setq org-agenda-tags-column -102)

;;
;; Agenda sorting functions
;;
(setq org-agenda-cmp-user-defined 'bh/agenda-sort)

(defun bh/agenda-sort (a b)
  "Sorting strategy for agenda items.
Late deadlines first, then scheduled, then non-late deadlines"
  (let (result num-a num-b)
    (cond
     ; time specific items are already sorted first by org-agenda-sorting-strategy

     ; non-deadline and non-scheduled items next
     ((bh/agenda-sort-test 'bh/is-not-scheduled-or-deadline a b))

     ; deadlines for today next
     ((bh/agenda-sort-test 'bh/is-due-deadline a b))

     ; late deadlines next
     ((bh/agenda-sort-test-num 'bh/is-late-deadline '< a b))

     ; scheduled items for today next
     ((bh/agenda-sort-test 'bh/is-scheduled-today a b))

     ; late scheduled items next
     ((bh/agenda-sort-test-num 'bh/is-scheduled-late '> a b))

     ; pending deadlines last
     ((bh/agenda-sort-test-num 'bh/is-pending-deadline '< a b))

     ; finally default to unsorted
     (t (setq result nil)))
    result))

(defmacro bh/agenda-sort-test (fn a b)
  "Test for agenda sort"
  `(cond
    ; if both match leave them unsorted
    ((and (apply ,fn (list ,a))
          (apply ,fn (list ,b)))
     (setq result nil))
    ; if a matches put a first
    ((apply ,fn (list ,a))
     (setq result -1))
    ; otherwise if b matches put b first
    ((apply ,fn (list ,b))
     (setq result 1))
    ; if none match leave them unsorted
    (t nil)))

(defmacro bh/agenda-sort-test-num (fn compfn a b)
  `(cond
    ((apply ,fn (list ,a))
     (setq num-a (string-to-number (match-string 1 ,a)))
     (if (apply ,fn (list ,b))
         (progn
           (setq num-b (string-to-number (match-string 1 ,b)))
           (setq result (if (apply ,compfn (list num-a num-b))
                            -1
                          1)))
       (setq result -1)))
    ((apply ,fn (list ,b))
     (setq result 1))
    (t nil)))

(defun bh/is-not-scheduled-or-deadline (date-str)
  (and (not (bh/is-deadline date-str))
       (not (bh/is-scheduled date-str))))

(defun bh/is-due-deadline (date-str)
  (string-match "Deadline:" date-str))

(defun bh/is-late-deadline (date-str)
  (string-match "In *\\(-.*\\)d\.:" date-str))

(defun bh/is-pending-deadline (date-str)
  (string-match "In \\([^-]*\\)d\.:" date-str))

(defun bh/is-deadline (date-str)
  (or (bh/is-due-deadline date-str)
      (bh/is-late-deadline date-str)
      (bh/is-pending-deadline date-str)))

(defun bh/is-scheduled (date-str)
  (or (bh/is-scheduled-today date-str)
      (bh/is-scheduled-late date-str)))

(defun bh/is-scheduled-today (date-str)
  (string-match "Scheduled:" date-str))

(defun bh/is-scheduled-late (date-str)
  (string-match "Sched\.\\(.*\\)x:" date-str))

;;Q Buries The Agenda View Buffer
(add-hook 'org-agenda-mode-hook
          (lambda ()
            (define-key org-agenda-mode-map "q" 'bury-buffer))
          'append)


;;Checklist Handling
(require 'org-checklist)

;;Handling Blocked Tasks
(setq org-enforce-todo-dependencies t)

;;Org-Indent Mode
(setq org-startup-indented t)

;Handling Blank Lines
(setq org-cycle-separator-lines 0)

;Searching And Showing Results
(setq org-show-following-heading t)
(setq org-show-hierarchy-above t)
(setq org-show-siblings (quote ((default))))

;Deadlines And Agenda Visibility
(setq org-deadline-warning-days 30)

;;NEXT is for TASKS
(defun bh/mark-next-parent-tasks-todo ()
  "Visit each parent task and change NEXT states to TODO"
  (let ((mystate (or (and (fboundp 'state)
                          state)
                     (nth 2 (org-heading-components)))))
    (when (equal mystate "NEXT")
      (save-excursion
        (while (org-up-heading-safe)
          (when (member (nth 2 (org-heading-components)) (list "NEXT"))
            (org-todo "TODO")))))))

(add-hook 'org-after-todo-state-change-hook 'bh/mark-next-parent-tasks-todo 'append)
(add-hook 'org-clock-in-hook 'bh/mark-next-parent-tasks-todo 'append)

;;Startup in Content View
(setq org-startup-folded 'content)

;;Automatic hourly saving
(run-at-time "00:59" 3600 'org-save-all-org-buffers)

;; Remove Multiple State Change Log Details From The Agenda
(setq org-agenda-skip-additional-timestamps-same-entry t)

;; Skip deadline prewarning if a task is scheduled
(setq org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)

;; Use System Settings for File-Application Selection
(setq org-file-apps (quote ((auto-mode . emacs)
                            ("\\.mm\\'" . system)
                            ("\\.x?html?\\'" . system)
                            ("\\.pdf\\'" . system))))

;; Publishing and exporting
(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
         (dot . t)
         (ditaa . t)
         (R . t)
         (python . t)
         (ruby . t)
         (gnuplot . t)
         (clojure . t)
         (sh . t)
         (ledger . t)
         (org . t)
         (plantuml . t)
         (latex . t))))

(add-hook 'org-clock-in-prepare-hook
          'pc/org-mode-ask-effort)

(defun pc/org-mode-ask-effort ()
  "Ask for an effort estimate when clocking in."
  (unless (org-entry-get (point) "Effort")
    (let ((effort
           (completing-read
            "Effort: "
            (org-entry-get-multivalued-property (point) "Effort"))))
      (unless (equal effort "")
        (org-set-property "Effort" effort)))))

;;;;;;;;;;;;;;;;;
;;
;; Org-Latex
;;
;;;;;;;;;;;;;;;;;

;;(require 'org-latex)
(require 'ox-latex)
;;(setq org-export-latex-listings t)
(setq org-latex-listings t)
(add-to-list 'org-latex-classes
             '("article-phil"
               "\\documentclass{article}
               [NO-DEFAULT-PACKAGES]
               [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
             '("book-phil"
               "\\documentclass{book}
               [NO-DEFAULT-PACKAGES]
               [EXTRA]"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
             '("uiothesis"
               "\\documentclass{uiothesis}
               [NO-DEFAULT-PACKAGES]
               [EXTRA]"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
	"bibtex %o/%f"
	"pdflatex -interaction nonstopmode -output-directory %o %f"
	"pdflatex -interaction nonstopmode -output-directory %o %f"))


;; CDLatex
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;;;;;;;;;;;;;;;;;
;;
;; Org-Publish-Projects
;;
;;;;;;;;;;;;;;;;;

;;(require 'org-publish)
(require 'ox-publish)
(require 'ox-latex)
(require 'ox-html)

;; Set the publish project to be empty
(setq org-publish-project-alist '())

;; Research Journal
(add-to-list 'org-publish-project-alist
	     '("researchjournal"
	       :base-directory "~/projects/org/"
	       :base-extension "org"
	       :publishing-directory "~/projects/org/research/export/"
	       :publishing-function org-latex-publish-to-pdf
	       :title "Research Journal"
	       :include ("researchjournal.org")
	       :exclude "\\.org$"
	       )
	     )

;; Big Wins
(add-to-list 'org-publish-project-alist
	     '("bigwins"
	       :base-directory "~/projects/org/"
	       :base-extension "org"
	       :publishing-directory "~/projects/org/docs/"
	       :publishing-function org-latex-publish-to-pdf
	       :title "Big Wins"
	       :include ("journal.org")
	       :exclude "\\.org$"
	       :select-tags ("bigwins")
	       :with-toc nil
	       )
	     )

(defun pc/update-dblock-then-save ()
  (let* (
	 (filelist (plist-get project-plist :include))
	 (outdir (plist-get project-plist :base-directory))
	 (orgfilename (expand-file-name (concat outdir (car filelist))))
	 (orgfilenamesimple (car filelist))
	 )
    ;; Open the file
    (find-file orgfilename)
    (with-current-buffer orgfilenamesimple
      (widen)
      ;; Go to the beginning of the buffer
      (goto-char (point-min))
      ;; Update the dblock
      (org-dblock-update)
      (save-buffer)))
  )


(defun pc/rename-with-date ()
  (let* (
	 (filelist (plist-get project-plist :include))
	 (outdir (plist-get project-plist :publishing-directory))
	 (orgfilename (expand-file-name (concat outdir (car filelist))))
	 )
    ;; Create the filename that we want to copy
    (setq htmlfilename (replace-regexp-in-string "\\.org" ".html" orgfilename))
    ;; Create a suffix with the date
    (setq ending (concat "_" (format-time-string "%Y_%m_%d") ".html"))
    (setq outfilename (replace-regexp-in-string "\\.org" ending orgfilename))
    ;; Copy the file
    (copy-file htmlfilename outfilename t))
  )

;;;;;;;;;;;;;;;;;
;;
;; Org-Paper-Manager
;;
;;;;;;;;;;;;;;;;;

;; Reftex setup

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name) (file-exists-p (buffer-file-name))
       (progn
	       ;enable auto-revert-mode to update reftex when bibtex file changes on disk
	       (global-auto-revert-mode t)
	       (setq-default TeX-master "researchjournal.org")
	       (reftex-parse-all)
	       ;add a custom reftex cite format to insert links
	       (reftex-set-cite-format
	         '((?c . "\\cite{%l}")
	           (?l . "%l")
	           (?t . "%t")
	           (?b . "[[bib:%l][%l-bib]]")
	           (?n . "[[notes:%l][%l-notes]]")
	           (?p . "[[papers:%l][%l-paper]]")
	           (?h . "** %t\n:PROPERTIES:\n:Custom_ID: %l\n:END:\n[[papers:%l][%l-paper]]")))))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  (define-key org-mode-map (kbd "C-c (") 'org-mode-reftex-search))

;; Disabled org-mode reftex integration, 
;; too time consuming and i'm phasing it out in favour of zotero
;;(add-hook 'org-mode-hook 'org-mode-reftex-setup)

;; Jump to entry
(defun org-mode-reftex-search ()
  ;;jump to the notes for the paper pointed to at from reftex search
  (interactive)
  (org-open-link-from-string (format "[[notes:%s]]" (reftex-citation t))))

;; Add a LaTeX \bibliography tag in the org-mode file
;; # \bibliography{~/research/refs.bib}

;; Link abbreviations
(setq org-link-abbrev-alist
      '(("bib" . "~/projects/org/research/refs.bib::%s")
	("notes" . "~/projects/org/research/researchjournal.org::#%s")
	("papers" . "~/projects/org/research/papers/%s.pdf")))

;; TODO 
;; I can't use this because my pdf files aren't named using the bibtex citation key
;; Mendeley does store the file name in the bibtex entry
;; It's a matter of extracting the file name from the entry -- elisp code again


(defun pc/reftex-get-data (key data)
  (let* ((files (reftex-get-bibfile-list))
	 (entry (condition-case nil
		    (save-excursion
		      (reftex-pop-to-bibtex-entry key files nil nil nil t))
		  (error
		   (if files
		       (message "cite: no such database entry: %s" key)
		     (message "%s" (substitute-command-keys
				    (format reftex-no-info-message "cite"))))
		   nil))))
    (when entry
      (cdr (assoc data (reftex-parse-bibtex-entry entry))))))

(defun pc/reftex-get-title ()
  (interactive)
  (let ((file (pc/reftex-get-data (current-word) "file")))
    (when file
      (let ((name (concat "/" (save-match-data
				(string-match ":\\(.*\\):pdf" file)
				(match-string 1 file)))))
	(find-file name)))))
