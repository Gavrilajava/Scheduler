
let current

async function  releaseLine(e) {
  e.preventDefault()
  const prev = document.querySelector('tr.solid')
  if (prev){
    prev.className = ''
  }
  let token = document.querySelector('[name=csrf-token]').content
  await current.parentNode.insertBefore( current, e.target.parentElement)
  fetch(window.location.href,{
    method: "PATCH",
    headers: {
      'X-CSRF-Token': token,
      'Content-Type': 'application/json'
    },
    credentials: 'same-origin',
    body: JSON.stringify({
      replace: {
        position: e.target.parentElement.id,
        order: current.id
      }
    })
  })
  .then(location.reload())
  
}

const allowDrop = e => {
  e.preventDefault()
  const prev = document.querySelector('tr.solid')
  if (prev){
    prev.className = ''
  }
  e.target.parentElement.className = "solid"
}

const drag = e => {
  current = e.target
  e.dataTransfer.setData("text", e.target.id);
}