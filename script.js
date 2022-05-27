fetch("http://localhost:3000/books",{
    mode: 'no-cors'
})
  .then((response) => {
    if (response.ok) {
      response = response.json();
      console.log(response)
    } else {
      throw new Error("NETWORK RESPONSE ERROR");
    }
  })
  // .then(data => {
  //   console.log(data);
  //   displayCocktail(data)
  // })
  .catch((error) => console.error("FETCH ERROR:", error));