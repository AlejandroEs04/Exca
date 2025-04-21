export function isNullOrEmpty(value: string | number) : boolean {
    if( value === null || value === undefined || value === '') {
        return true;
    }

    return false;
}

export const currencyFormat = (amount : number) => {
    return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(amount);
}