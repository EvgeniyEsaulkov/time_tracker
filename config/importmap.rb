# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "morphdom", to: "https://ga.jspm.io/npm:morphdom@2.7.0/dist/morphdom-esm.js"
pin "flowbite", to: "https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.8.1/flowbite.turbo.min.js"
pin "turbo_power", to: "https://ga.jspm.io/npm:turbo_power@0.4.0/dist/turbo_power.js"
