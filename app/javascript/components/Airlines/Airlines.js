import React, { useState, useEffect, Fragment } from 'react'
import axios from 'axios'

const Airlines = () => {
    const [airlines, setAirlines] = useState([])

    useEffect(() => {
        //Get all of our airlines from api
        //Update airlines in our state

        axios.get('/api/v1/airlines.json')
            //update the value in our state
            .then(res => setAirlines(res.data.data))
            .catch(res => console.log(res))
    }, [airlines.length]) //as backup

    const list = airlines.map(item => {
        return (<li key={item.attributes.name}>{item.attributes.name}</li>)
    })

    return (
        <>
            <div className="home">
                <div className="header">
                    <h1>OpenFlights</h1>
                    <div className="subheader">Honest, unbiased airline reviews.</div>
                </div>
                <div className="grid">
                    <ul>{list}</ul>
                </div>
            </div>
        </>
    )
}

export default Airlines