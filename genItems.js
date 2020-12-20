const fs = require("fs").promises

;(async () => {
  const files = await fs.readdir("./public")

  const audios = files.filter(name => name.includes("mp3"))
  const images = files.filter(name => !name.includes("mp3"))
  const combined = []

  for (let i = 0; i < audios.length; i++) {
    combined.push({
      audioSrc: audios[i],
      imageSrc: images[i]
    })
  }

  let json = JSON.stringify(combined, ["audioSrc", "imageSrc"], 2)
  const targets = [
    { from: '"audioSrc"', to: 'audioSrc' },
    { from: '"imageSrc"', to: 'imageSrc' }
  ]

  for (let target of targets) {
    while (json.includes(target.from)) {
      json = json.replace(target.from, target.to)
    }
  }

  await fs.writeFile("items.txt", json)
})()