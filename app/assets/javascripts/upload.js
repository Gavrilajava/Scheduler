document.addEventListener('DOMContentLoaded', () => {
  let input = document.querySelector('input#upload')
  let label = document.querySelector('label#filename')
  input.addEventListener( 'change', e => {
    label.innerText = event.srcElement.files[0].name
  })
})