const express = require("express")
const mysql = require("mysql")

const app = express()
const port = 8000
const table = "donut"

const pool = mysql.createPool({
	host: "donutsdb-instance-1.c62rcdsu4itb.us-east-2.rds.amazonaws.com",
	user: "admin",
	password: "donuts531",
	database: "donuts_schema",
})

app.listen(port, () => {
	console.log(`App server now listening to port ${port}`)
})

app.get("/api/donuts", (req, res) => {
	pool.query(`select * from ${table}`, (err, rows) => {
		if (err) {
			res.send(err)
		} else {
			console.log(res)
			res.send(rows)
		}
	})
})
