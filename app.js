
require("dotenv").config();
const express= require("express");
const app=express();
const PORT=process.env.PORT || 3000;
const db=require("./db");

//get all offices

app.use(express.urlencoded({extended:true}));

app.get("/offices",async(req,res)=> {
const result=await db.query("SELECT * FROM offices");
res.send(result.rows)
})

app.post("/offices",async(req,res)=> {

    try {
        const {office_code,office_name} =req.body;
        
        const result=await db.query("INSERT INTO offices (office_code,office_name) VALUES ($1,$2) RETURNING *",[office_code,office_name]);
   res.redirect("/offices");

    } catch (err) {
        console.error(err)
    }
   
})


app.listen(PORT,()=> {
    console.log(`Server started at ${PORT}`)
})