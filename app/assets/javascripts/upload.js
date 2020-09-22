document.addEventListener('DOMContentLoaded', () => {
  let input = document.querySelector('input#upload')
  let label = document.querySelector('label#filename')
  if (input && label){
    input.addEventListener( 'change', e => {
      label.innerText = event.srcElement.files[0].name
    })
  }
})