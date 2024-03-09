
<h1>TASK 1</h1>

### Place in `faa` model
```cmd
explore: +flights {
  query: start_from_here{
      dimensions: [depart_week, distance_tiered]
      measures: [count]
      filters: [flights.depart_date: "2003"]
    }
  }
```
Choose <b>Line</b> in Visualization bar

Search `Distance Tiered` > Pivot

Click Edit > Plot
- Select the Legend Align as Left

Gear icon next to Run, and select Save > As a Look.

Title:- `Flight Count by Departure Week and Distance Tier`


<hr>
<br> 


# TASK 2
### Place in `faa` model
```cmd
explore: +flights {
  query: start_from_here{
      dimensions: [aircraft_origin.state]
      measures: [percent_cancelled]
      filters: [flights.depart_date: "2000"]
    }
  }
```

Select <b>Line</b> in Visualization Bar

Title:- `Percent of Flights Cancelled by State in 2000`



<hr>
<br>

<h1>TASK 3</h1>

### Place in `faa` model
```cmd
explore: +flights {
    query: start_from_here{
      dimensions: [aircraft_origin.state]
      measures: [cancelled_count, count]
      filters: [flights.depart_date: "2004"]
    }
}
```

Click <b>+ ADD</b> button > Table Calculation
- Formula `${flights.cancelled_count}/${flights.count}`

Gear icon next to Run, and select Save > As a Look

Title:- Percent of Flights Cancelled by Aircraft Origin 2004



<hr>
<br>

# TASK 4

### Place in `faa` model
```cmd
explore: +flights {
    query: start_from_here{
      dimensions: [carriers.name]
      measures: [total_distance]
    }
}
```
Check the <b>`Table` Checkbox</b> in 3rd Bar (below Visualization bar).

Click <b>+ ADD</b> button > Table Calculation
- Fomula `${flights.total_distance}/${flights.total_distance:total}`

Choose <b>Bar</b> in Visualization bar

Run> Gear icon next to Run, and select Save > As a Look

Title:- `Percent of Total Distance Flown by Carrier`


<hr>
<br>

# TASK 5

### Place in `faa` model
```cmd
explore: +flights {
    query:start_from_here {
      dimensions: [depart_year, distance_tiered]
      measures: [count]
      filters: [flights.depart_date: "after 2000/01/01"]
    }
}
```

Click `+ ADD` button > Table Calculation
- Formula `(${flights.count}-pivot_offset(${flights.count}, -1))/pivot_offset(${flights.count}, -1)`

Search `Depart Date` in dimension group, click on the Pivot data button next to the `Year` dimension

Choose <b>Table</b> in Visualization Bar

Click Edit > Formatting.
- Toggle the Enable Conditional Formatting to on
- Accept the default options and click Add a Rule.

Click on Run > Gear icon next to Run, and select Save > As a Look

Title:- `YoY Percent Change in Flights flown by Distance, 2000-Present`