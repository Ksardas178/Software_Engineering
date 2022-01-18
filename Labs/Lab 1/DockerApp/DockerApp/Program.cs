using System;

namespace DockerApp
{
    enum Scales
    {
        celsius = 'c',
        fahrenheit = 'f',
        kelvin = 'k'
    }

    class ParseData
    {
        public Scales scaleFrom, scaleTo;
        public double value;
        private bool valid;

        public ParseData(string scaleFrom, string value, string scaleTo)
        {
            valid = false;
            if (!TryParseScale(scaleFrom, ref this.scaleFrom))
            {
                Console.WriteLine("Invalid 1st key. Check your input");
            }
            else if (!TryParseScale(scaleTo, ref this.scaleTo))
            {
                Console.WriteLine("Invald 2nd key. Check your input");
            }
            else if (!double.TryParse(value, out this.value))
            {
                Console.WriteLine("Invalid value. Check your input");
            }
            else
            {
                this.value = toKelvin(this.scaleFrom, this.value);
                valid = CheckRange(this.value);
            }
        }

        private bool TryParseScale(string arg, ref Scales scale)
        {
            if ((arg.Length == 2) &&
                Scales.IsDefined(typeof(Scales), (Scales)arg[1]) &&
                (arg[0] == '-'))
            {
                scale = (Scales)arg[1];
                return true;
            }
            return false;
        }

        private double toScale(Scales scale, double value)
        {
            //From Kelvin to desired scale
            switch (scale)
            {
                case Scales.fahrenheit:
                    return (value - 273.15) * 9 / 5 + 32;
                case Scales.celsius:
                    return value - 273.15;
                default:
                    return value;
            }
        }

        private double toKelvin(Scales scale, double value)
        {
            //From input scale to Kelvin
            switch (scale)
            {
                case Scales.celsius:
                    return value + 273.15;
                case Scales.fahrenheit:
                    return (value - 32) * 5 / 9 + 273.15;
                default:
                    return value;
            }
        }

        public void Convert()
        {
            if (valid)
            {
                double result = toScale(this.scaleTo, this.value);
                Console.WriteLine($"Result: {result}\n");
            }
        }

        private bool CheckRange(double value)
        {
            //Possible temperature range (Kelvin)
            if (value >= 0 && value < 1.4168 * Math.Pow(10, 32) + 273.15)
            {
                return true;
            }
            Console.WriteLine("Unreachable temperature value. Check your input");
            return false;
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length < 3)
            {
                Console.WriteLine("Too less arguments. Check your input");
            }
            else if (args.Length > 3)
            {
                Console.WriteLine("Too much arguments. Check your input");
            }
            else
            {
                var parseData = new ParseData(args[0], args[1], args[2]);
                parseData.Convert();
            }            
        }
    }
}