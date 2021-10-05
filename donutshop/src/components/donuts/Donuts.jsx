import React from "react"
import { useEffect, useState } from "react"

const Donuts = () => {
	const [donuts, setDonuts] = useState([])

	const fetchDonuts = async () => {
		// You can await here
		const response = await fetch(`/api/users`).then((response) => response.json())
		setDonuts(response)
	}

	useEffect(() => {
		fetchDonuts()
	}, [])

	return (
		<div className="text-center">
			<header>
				<h1 className="donut-header">Doughnuts</h1>
				<small>Daily selection varies by shop</small>
			</header>

			<div className="donuts">
				{donuts.map((donut) => (
					<div className="card" key={donut.id}>
						<img src={donut.imgUrl} className="card-img-top" alt="..." />
						<div className="card-body">
							<h5 className="card-title">Card title</h5>
							<p className="card-text">{donut.name}</p>
						</div>
					</div>
				))}
			</div>
		</div>
	)
}

export default Donuts

// export function SampleComponent() {
//   return (
//     <div>
//       This is a sample component
//       {getUsers()}
//     </div>
//   );
// }
