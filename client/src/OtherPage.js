import React from 'react';
import { Link } from 'react-router-dom';

export default () => {
  return (
    <div>
      The Fibonacci sequence is a series of numbers in which each number is the sum of the two preceding numbers. The simplest is the series 1, 1, 2, 3, 5, 8, 13...  
      <Link to="/"> Go back home </Link>
    </div>
  );
};
