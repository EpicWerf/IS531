import React from "react"
import { useEffect, useState } from "react"

const Donuts = () => {
	// this is the getter / setter for the state variables "donuts", "filtersList", and "filteredDonuts"
	const [donuts, setDonuts] = useState([])
	const [filtersList, setFiltersList] = useState([])
	const [filteredDonuts, setFilteredDonuts] = useState([])

	//upon page load, this function goes to the DB to get all the donuts
	const fetchDonuts = async () => {
		// Turn the response into JSON
		const response = await fetch(`/api/donuts`).then((response) =>
			response.json()
		)

		// Set the state variable "donuts" to the JSON response
		setDonuts(response)
		setFilteredDonuts(response)

		//Set the filters to the an array of donut types
		let donutTypes = response.map((donut) => donut.type)
		donutTypes = donutTypes.filter(
			(donutType, index, self) => self.indexOf(donutType) === index
		)
		setFiltersList([...donutTypes])
	}

	//this function is called when the user clicks on a filter
	const handleFilterChange = (event) => {
		event.preventDefault()

		//get the value of the filter
		const selectedOption = event.currentTarget.value

		//filter the donuts based on the selected option
		const copy = donuts.filter((donut) => donut.type === selectedOption)
		
		//set the filtered array to the filtered copy of donuts
		//that way "donuts" remains the full list of donuts
		setFilteredDonuts([...copy])
	}

	//this function is called when the user clicks the "All" filter
	const resetFilters = () => {
		setFilteredDonuts([...donuts])
	}

	//useEffect just means to run the "fetchDonuts" function when the page loads
	useEffect(() => {
		fetchDonuts()
	}, [])

	return (
		<div className="text-center">
			<header>
				<h1 className="donut-header">Doughnuts</h1>
				<small>Daily selection varies by shop</small>
			</header>

			<div style={{ marginBottom: "10px", marginTop: "10px" }}>
				<button
					type="button"
					className="btn btn-success"
					onClick={resetFilters}
					value="All"
				>
					All
				</button>
				{filtersList.map((filter) => (
					<button
						type="button"
						className="btn btn-success"
						onClick={handleFilterChange}
						value={filter}
						key={filter}
						style={{ marginLeft: "10px" }}
					>
						{filter}
					</button>
				))}
			</div>

			<div className="donuts container">
				{/* array.map will go through all elements in an array and make a card out of them */}
				<div className="row">
					{filteredDonuts.map((donut) => (
						<div className="card col-sm-3" key={donut.id}>
							<img
								src={donut.image_url}
								className="card-img-top img-fluid"
								alt="..."
							/>
							<div className="card-body">
								<h5 className="card-title">{donut.name}</h5>
								<p className="card-text">{donut.type}</p>
							</div>
						</div>
					))}
				</div>
			</div>
		</div>
	)
}

export default Donuts
