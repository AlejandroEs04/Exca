export function isNullOrEmpty(value: string | number) : boolean {
    if( value === null || value === undefined || value === '') {
        return true;
    }

    return false;
}

export const currencyFormat = (amount : number) => {
    return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(amount);
}

export const dateFormat = (date: string) => {
    const newDate = new Date(date);

    const options: Intl.DateTimeFormatOptions = {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: 'numeric',
        minute: '2-digit',
        hour12: true
    };

    const prettyFormat = newDate.toLocaleString('es-ES', options);
    return prettyFormat
}

export const isInputHelper = (target: EventTarget): target is HTMLInputElement => {
    return (target as HTMLInputElement).checked !== undefined;
};
export const formatToCurrency = (value: string | number): string => {
    const num = typeof value === 'number' ? value : parseFloat(String(value).replace(/[^0-9.]/g, ''))
    if (isNaN(num)) return ''
    return new Intl.NumberFormat('es-MX', {
        style: 'currency',
        currency: 'MXN',
        minimumFractionDigits: 2,
    }).format(num)
}