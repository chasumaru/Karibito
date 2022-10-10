// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)

// tailwindcss-stimulus-componentsの追加
import {Dropdown, Modal, Tabs} from "tailwindcss-stimulus-components"
application.register('dropdown', Dropdown)
application.register('tabs', Tabs)

import Notification from 'stimulus-notification'
application.register('notification', Notification)

import CharacterCounter from 'stimulus-character-counter'
application.register('character-counter', CharacterCounter)