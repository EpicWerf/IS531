import logo from "./logo.svg"
import "./App.css"

function App() {
	return (
		<div className="App">
			<header>
				<h1 className="donut-header">Doughnuts</h1>
				<p>Daily selection varies by shop</p>
				<a
					className="App-link"
					href="https://reactjs.org"
					target="_blank"
					rel="noopener noreferrer"
				>
					Learn React
				</a>
				<img src={logo} className="App-logo" alt="logo" />
			</header>
		</div>
	)
}

export default App
